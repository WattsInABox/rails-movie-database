require 'test_helper'

class ListsControllerTest < ActionController::TestCase
  setup do
    @list = FactoryGirl.create(:list)
  end

  should "get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lists)
  end

  should "get new" do
    get :new
    assert_response :success
  end

  should "create list" do
    assert_difference('List.count') do
      post :create, list: { color: @list.color, name: @list.name }
    end

    assert_redirected_to list_path(assigns(:list))
  end

  should "show list" do
    get :show, id: @list
    assert_response :success
  end

  should "get edit" do
    get :edit, id: @list
    assert_response :success
  end

  should "update list" do
    put :update, id: @list, list: { color: @list.color, name: @list.name }
    assert_redirected_to list_path(assigns(:list))
  end

  should "destroy list" do
    assert_difference('List.count', -1) do
      delete :destroy, id: @list
    end

    assert_redirected_to lists_path
  end
end
