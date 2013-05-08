require_relative '../test_helper'

class MoviesControllerTest < ActionController::TestCase
  context "with existing movies" do
    setup do
      @movie = FactoryGirl.create(:movie, lists: [FactoryGirl.create(:list)])
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

      assert_redirected_to @movie.lists.first
    end
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
    list = FactoryGirl.create(:list)
    list2 = FactoryGirl.create(:list)

    assert_difference('Movie.count') do
      # it's important that the list IDs be seperated by a 
      # comma and then a space (including the space at the end) 
      # because that it is how the JQuery interface component will send the 
      # list IDs
      movie = FactoryGirl.attributes_for(:movie, lists: "#{list.id}, #{list2.id}, ")
      post :create, movie: movie
    end

    assert_same_elements [list, list2], Movie.first.lists

    assert_redirected_to lists_path
  end

  should "search" do
    imdb_id = 123
    label = 'Top Gear Season 1: An amazing thing about stuff'
    movie = mock('movie') do
      expects('imdb_id').returns(imdb_id).at_least_once
      expects('label').returns(label).at_least_once
    end

    Movie.expects(:search).with('Top Gear').returns([movie])
    get :search, format: 'json', term: 'Top Gear'

    movies = assigns(:movies)
    assert_not_nil movies
    assert_equal 1, movies.length
    assert_response :success

    # use the value-label format for jquery autocomplete
    # from the docs:
    # An array of objects with label and value properties: [ { label: "Choice1", value: "value1" }, ... ]
    assert_equal label, movies.first[:label], "Label for the dropdown should be the movie's title and tagline"
    assert_equal imdb_id, movies.first[:value], "Value in the dropdown should be the movie's IMDB ID"
  end
end
