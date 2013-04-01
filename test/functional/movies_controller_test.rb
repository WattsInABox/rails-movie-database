require_relative '../test_helper'

class MoviesControllerTest < ActionController::TestCase
  setup do
    @movie = FactoryGirl.create(:movie)
  end

  should "get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movies)
  end

  should "get new" do
    get :new
    assert_response :success
  end

  should "create movie" do
    assert_difference('Movie.count') do
      post :create, movie: FactoryGirl.attributes_for(:movie)
    end

    assert_redirected_to movie_path(assigns(:movie))
  end

  should "show movie" do
    get :show, id: @movie
    assert_response :success
  end

  should "get edit" do
    get :edit, id: @movie
    assert_response :success
  end

  should "update movie" do
    put :update, id: @movie, movie: {  }
    assert_redirected_to movie_path(assigns(:movie))
  end

  should "destroy movie" do
    assert_difference('Movie.count', -1) do
      delete :destroy, id: @movie
    end

    assert_redirected_to movies_path
  end

  should "search" do
    get :search, format: 'json', query: 'Top Gear'

    assert_not_nil assigns(:movies)
    assert_response :success
  end
end
