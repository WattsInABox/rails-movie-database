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
    movie = FactoryGirl.create(:movie)
    Movie.expects(:search).with('Top Gear').returns([movie])
    get :search, format: 'json', term: 'Top Gear'

    movies = assigns(:movies)
    assert_not_nil movies
    assert_response :success

    # use the value-label format for jquery autocomplete
    # from the docs:
    # An array of objects with label and value properties: [ { label: "Choice1", value: "value1" }, ... ]
    assert_equal "#{movie.title}: #{movie.short_description}", movies.first[:label], "Label should be the movie's title and short description"
    assert_equal movie.imdb_id, movies.first[:value], "Value should be the movie's IMDB ID"
  end
end
