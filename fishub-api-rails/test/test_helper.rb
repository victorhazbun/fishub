ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.

  fixtures :all

  # Parse JSON response to Ruby hash
  def json_response
    JSON.parse(response.body, symbolize_names: true)
  end

  def sign_in_as(user)
    credentials = {
      session: {
        username: user.username,
        password: 'secret'
      }
    }

    post session_url, params: credentials

    assert_response :created
    assert_equal user.id, session[:user_id]
  end
end
