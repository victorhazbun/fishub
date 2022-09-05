require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "POST :create with valid crendentials returns authenticated user" do
    user = users(:example)

    valid_credentials = {
      session: { 
        username: user.username, 
        password: 'secret'
      } 
    }

    post session_url, params: valid_credentials

    assert_response :created
    assert_equal user.id, session[:user_id]
    assert_equal json_response, {username: user.username}
  end

  test "POST :create with invalid credentials fails" do
    user = users(:example)

    invalid_credentials = {
      session: { 
        username: user.username, 
        password: 'wrong-password'
      } 
    }

    post session_url, params: invalid_credentials

    assert_response :unauthorized 
    assert_nil request.session[:user_id]
    assert_match /Invalid credentials/, json_response[:error]
    assert_nil json_response[:username]
  end

  test "DELETE :destroy" do
    sign_in_as(users(:example))

    delete session_url

    assert_response :ok
    assert_nil request.session[:user_id]
  end
end
