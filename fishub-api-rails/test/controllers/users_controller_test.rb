require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  test "POST :create returns user" do
    valid_params = {
      user: { 
        username: "test", 
        password: "secret"
      } 
    }

    assert_difference('User.count') do
      post users_url, params: valid_params
    end

    assert_response :created  # 201
    assert json_response[:username]
  end

  test "POST :create fails when params are missing" do

    invalid_params = {
      user: { 
        username: "",
        password: ""
      } 
    }

    assert_no_difference('User.count') do
      post users_url, params: invalid_params
    end

    assert_response :unprocessable_entity  # 422
    assert_includes json_response, :errors
    assert_includes json_response[:errors], :username
    assert_includes json_response[:errors], :password
  end

  test "POST :create fails when username has already been taken" do
    user = users(:example)

    invalid_params = {
      user: { 
        username: user.username,
        password: "secret"
      } 
    }

    assert_no_difference('User.count') do
      post users_url, params: invalid_params
    end
    
    assert_response :unprocessable_entity  # 422
    assert_includes json_response, :errors
    assert_includes json_response[:errors], :username
  end
end