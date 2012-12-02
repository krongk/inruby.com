require 'test_helper'

class SearchItemsControllerTest < ActionController::TestCase
  setup do
    @search_item = search_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:search_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create search_item" do
    assert_difference('SearchItem.count') do
      post :create, search_item: @search_item.attributes
    end

    assert_redirected_to search_item_path(assigns(:search_item))
  end

  test "should show search_item" do
    get :show, id: @search_item.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @search_item.to_param
    assert_response :success
  end

  test "should update search_item" do
    put :update, id: @search_item.to_param, search_item: @search_item.attributes
    assert_redirected_to search_item_path(assigns(:search_item))
  end

  test "should destroy search_item" do
    assert_difference('SearchItem.count', -1) do
      delete :destroy, id: @search_item.to_param
    end

    assert_redirected_to search_items_path
  end
end
