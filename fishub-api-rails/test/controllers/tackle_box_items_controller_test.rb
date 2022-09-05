require 'test_helper'

class TackleBoxItemsControllerTest < ActionDispatch::IntegrationTest
  test "GET :index fails when not authorized" do
    get tackle_box_items_url

    assert_response :unauthorized  # 401
    assert_equal "Requires authentication", json_response[:error]
  end

  test "GET :index succeeds when authorized" do
    user = users(:example)
    
    sign_in_as(user)

    get tackle_box_items_url

    assert_response :success
    assert_equal user.tackle_box_items.length, json_response.length
  end

  test "POST :create fails when not authorized" do
    assert_no_difference('TackleBoxItem.count') do
      post tackle_box_items_url, 
             params: { tackle_box_item: { bait_id: 1 } }
    end

    assert_response :unauthorized  # 401
    assert_equal "Requires authentication", json_response[:error]
  end

  test "POST :create succeeds when authorized" do
    user = users(:example)

    sign_in_as(user)

    bait = baits(:fat_rap)

    valid_params = {
      tackle_box_item: {
        bait_id: bait.id
      }
    }

    assert_difference('TackleBoxItem.count') do
      post tackle_box_items_url, params: valid_params
    end

    assert_response :created  # 201
    assert_equal bait.name, json_response[:bait][:name]
  end

  test "POST :create fails when params are invalid" do
    user = users(:example)

    sign_in_as(user)

    invalid_params = {
      tackle_box_item: {
        bait_id: "abc"
      }
    }

    assert_no_difference('TackleBoxItem.count') do
      post tackle_box_items_url, params: invalid_params
    end
    
    assert_response :unprocessable_entity  # 422
    assert_includes json_response, :errors
    assert_includes json_response[:errors], :bait
  end
end
