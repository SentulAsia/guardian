require 'test_helper'

class PortalsControllerTest < ActionController::TestCase
  setup do
    @portal = portals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:portals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create portal" do
    assert_difference('Portal.count') do
      post :create, portal: { day_of_150: @portal.day_of_150, age_points: @portal.age_points, agent_name: @portal.agent_name, bonus_details: @portal.bonus_details, bonus_points: @portal.bonus_points, captured_date: @portal.captured_date, city: @portal.city, destroyed_by: @portal.destroyed_by, destruction_date: @portal.destruction_date, lat_coordinate: @portal.lat_coordinate, link: @portal.link, lng_coordinate: @portal.lng_coordinate, location: @portal.location, note: @portal.note, portal_guid: @portal.portal_guid, portal_name: @portal.portal_name, status_string: @portal.status_string, total_points: @portal.total_points }
    end

    assert_redirected_to portal_path(assigns(:portal))
  end

  test "should show portal" do
    get :show, id: @portal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @portal
    assert_response :success
  end

  test "should update portal" do
    put :update, id: @portal, portal: { day_of_150: @portal.day_of_150, age_points: @portal.age_points, agent_name: @portal.agent_name, bonus_details: @portal.bonus_details, bonus_points: @portal.bonus_points, captured_date: @portal.captured_date, city: @portal.city, destroyed_by: @portal.destroyed_by, destruction_date: @portal.destruction_date, lat_coordinate: @portal.lat_coordinate, link: @portal.link, lng_coordinate: @portal.lng_coordinate, location: @portal.location, note: @portal.note, portal_guid: @portal.portal_guid, portal_name: @portal.portal_name, status_string: @portal.status_string, total_points: @portal.total_points }
    assert_redirected_to portal_path(assigns(:portal))
  end

  test "should destroy portal" do
    assert_difference('Portal.count', -1) do
      delete :destroy, id: @portal
    end

    assert_redirected_to portals_path
  end
end
