require 'test_helper'

class CheckPointsControllerTest < ActionController::TestCase
  setup do
    @check_point = check_points(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:check_points)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create check_point" do
    assert_difference('CheckPoint.count') do
      post :create, check_point: { event_id: @check_point.event_id, latitude: @check_point.latitude, longitude: @check_point.longitude, note: @check_point.note, number: @check_point.number }
    end

    assert_redirected_to check_point_path(assigns(:check_point))
  end

  test "should show check_point" do
    get :show, id: @check_point
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @check_point
    assert_response :success
  end

  test "should update check_point" do
    patch :update, id: @check_point, check_point: { event_id: @check_point.event_id, latitude: @check_point.latitude, longitude: @check_point.longitude, note: @check_point.note, number: @check_point.number }
    assert_redirected_to check_point_path(assigns(:check_point))
  end

  test "should destroy check_point" do
    assert_difference('CheckPoint.count', -1) do
      delete :destroy, id: @check_point
    end

    assert_redirected_to check_points_path
  end
end
