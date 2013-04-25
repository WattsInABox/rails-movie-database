require_relative '../test_helper'

class ListsControllerTest < ActionController::TestCase
  setup do
    @list = FactoryGirl.create(:list, name: 'mine')
    # have to save the movies seperately since they require at least list
    # also, save b first then a so that our sort test is valid
    %w(b a).each do |movie_title|
      FactoryGirl.build(:movie, title: movie_title, lists: [@list])  
    end
  end

  should "get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lists)
  end

  should "get index in JSON format and return lists matching a query parameter" do
    @list2 = FactoryGirl.create(:list, name: 'yours')

    get :index, format: 'json', term: 'mI' # use capital "I" to test if we're properly doing a case-insensitive search

    lists = assigns(:lists)
    assert_not_nil lists
    assert_response :success

    json_response = JSON(response.body)
    assert_equal [{"value" => @list.id, "label" => @list.name}], json_response
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

  should "show list with sorted movies" do
    get :show, id: @list
    assert_response :success
    assert_equal @list.movies.sort { |a, b| a.title <=> b.title }, assigns(:movies)
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
