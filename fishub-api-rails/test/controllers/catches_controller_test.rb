require 'test_helper'

class CatchesControllerTest < ActionDispatch::IntegrationTest

  test "GET :index fails when not signed in" do
    bait = baits(:fat_rap)

    get bait_catches_url(bait)

    assert_response :unauthorized  # 401
    assert_equal "Requires authentication", json_response[:error]
  end

  test "GET :index succeeds when signed in" do
    user = users(:example)
    bait = baits(:fat_rap)

    sign_in_as(user)
    
    get bait_catches_url(bait)

    assert_response :success

    catches_with_bait = user.catches.select { |c| c.bait.id == bait.id }

    assert_equal catches_with_bait.length, json_response.length
  end

  test "POST :create fails when not signed in" do
    bait = baits(:fat_rap)

    assert_no_difference('Catch.count') do
      post bait_catches_url(bait), params: { catch: { } }
    end

    assert_response :unauthorized  # 401
    assert_equal "Requires authentication", json_response[:error]
  end

  test "POST :create succeeds when signed in" do    
    user = users(:example)
    bait = baits(:fat_rap)

    sign_in_as(user)
    
    valid_params = {
      catch: {
        species: 'Rainbow Trout',
        weight: 4.0,
        length: 21.0
      }
    }
  
    assert_difference('Catch.count') do
      post bait_catches_url(bait), params: valid_params
    end

    assert_response :created  # 201
    assert_equal 'Rainbow Trout', json_response[:species]
  end

  test "POST :create fails when params are invalid" do
    sign_in_as(users(:example))

    bait = baits(:fat_rap)

    invalid_params = {
      catch: {
        species: ""
      }
    }

    assert_no_difference('Catch.count') do
      post bait_catches_url(bait), params: invalid_params
    end

    assert_response :unprocessable_entity  # 422
    assert_includes json_response, :errors
    assert_includes json_response[:errors], :weight
    assert_includes json_response[:errors], :length
  end
end
