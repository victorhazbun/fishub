require 'test_helper'

class BaitsControllerTest < ActionDispatch::IntegrationTest
  test "GET :index succeeds when not authorized" do
    get baits_url

    assert_response :success
    assert_equal baits.length, json_response.length
  end
end
