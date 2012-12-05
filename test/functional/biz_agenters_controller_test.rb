require 'test_helper'

class BizAgentersControllerTest < ActionController::TestCase
  setup do
    @biz_agenter = biz_agenters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:biz_agenters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create biz_agenter" do
    assert_difference('BizAgenter.count') do
      post :create, biz_agenter: @biz_agenter.attributes
    end

    assert_redirected_to biz_agenter_path(assigns(:biz_agenter))
  end

  test "should show biz_agenter" do
    get :show, id: @biz_agenter.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @biz_agenter.to_param
    assert_response :success
  end

  test "should update biz_agenter" do
    put :update, id: @biz_agenter.to_param, biz_agenter: @biz_agenter.attributes
    assert_redirected_to biz_agenter_path(assigns(:biz_agenter))
  end

  test "should destroy biz_agenter" do
    assert_difference('BizAgenter.count', -1) do
      delete :destroy, id: @biz_agenter.to_param
    end

    assert_redirected_to biz_agenters_path
  end
end
