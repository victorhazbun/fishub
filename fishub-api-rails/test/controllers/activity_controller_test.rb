require 'test_helper'

class ActivityControllerTest < ActionDispatch::IntegrationTest
  test "GET :index succeeds when not authorized" do
    get activity_url

    assert_response :success
    assert_equal catches.length, json_response.length
  end
end
