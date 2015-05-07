require 'test_helper'

class MenuEntriesControllerTest < ActionController::TestCase
  setup do
    @menu_entry = menu_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:menu_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create menu_entry" do
    assert_difference('MenuEntry.count') do
      post :create, menu_entry: { desert: @menu_entry.desert, entry_date: @menu_entry.entry_date, main: @menu_entry.main, meat: @menu_entry.meat, optional: @menu_entry.optional, period: @menu_entry.period, restaurant_id: @menu_entry.restaurant_id, salad: @menu_entry.salad, second: @menu_entry.second }
    end

    assert_redirected_to menu_entry_path(assigns(:menu_entry))
  end

  test "should show menu_entry" do
    get :show, id: @menu_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @menu_entry
    assert_response :success
  end

  test "should update menu_entry" do
    patch :update, id: @menu_entry, menu_entry: { desert: @menu_entry.desert, entry_date: @menu_entry.entry_date, main: @menu_entry.main, meat: @menu_entry.meat, optional: @menu_entry.optional, period: @menu_entry.period, restaurant_id: @menu_entry.restaurant_id, salad: @menu_entry.salad, second: @menu_entry.second }
    assert_redirected_to menu_entry_path(assigns(:menu_entry))
  end

  test "should destroy menu_entry" do
    assert_difference('MenuEntry.count', -1) do
      delete :destroy, id: @menu_entry
    end

    assert_redirected_to menu_entries_path
  end
end
