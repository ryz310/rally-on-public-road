require 'test_helper'

class RallyCarEventsControllerTest < ActionController::TestCase
  setup do
    @rally_car_event = rally_car_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rally_car_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rally_car_event" do
    assert_difference('RallyCarEvent.count') do
      post :create, rally_car_event: { beginning_on: @rally_car_event.beginning_on, end_on: @rally_car_event.end_on, name: @rally_car_event.name, note: @rally_car_event.note }
    end

    assert_redirected_to rally_car_event_path(assigns(:rally_car_event))
  end

  test "should show rally_car_event" do
    get :show, id: @rally_car_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rally_car_event
    assert_response :success
  end

  test "should update rally_car_event" do
    patch :update, id: @rally_car_event, rally_car_event: { beginning_on: @rally_car_event.beginning_on, end_on: @rally_car_event.end_on, name: @rally_car_event.name, note: @rally_car_event.note }
    assert_redirected_to rally_car_event_path(assigns(:rally_car_event))
  end

  test "should destroy rally_car_event" do
    assert_difference('RallyCarEvent.count', -1) do
      delete :destroy, id: @rally_car_event
    end

    assert_redirected_to rally_car_events_path
  end
end
