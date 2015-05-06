require 'test_helper'

class LineStatusesControllerTest < ActionController::TestCase
  setup do
    @line_status = line_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_status" do
    assert_difference('LineStatus.count') do
      post :create, line_status: { restaurant_id: @line_status.restaurant_id, status: @line_status.status, submit_date: @line_status.submit_date }
    end

    assert_redirected_to line_status_path(assigns(:line_status))
  end

  test "should show line_status" do
    get :show, id: @line_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @line_status
    assert_response :success
  end

  test "should update line_status" do
    patch :update, id: @line_status, line_status: { restaurant_id: @line_status.restaurant_id, status: @line_status.status, submit_date: @line_status.submit_date }
    assert_redirected_to line_status_path(assigns(:line_status))
  end

  test "should destroy line_status" do
    assert_difference('LineStatus.count', -1) do
      delete :destroy, id: @line_status
    end

    assert_redirected_to line_statuses_path
  end
end
