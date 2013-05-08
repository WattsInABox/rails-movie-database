require_relative '../test_helper'

# TODO this test should not depend on the internets
class MovieTest < ActiveSupport::TestCase
  context "search" do
    should "pull up to 10 movies from the movie database" do
      movies = Movie.search("top gear")

      assert_equal 10, movies.length
      assert_match /Top Gear/, movies.first.title
    end
  end

  context "initializing from Imdb" do
    should "init movie with genres" do
      movie = Movie.initialize_from_imdb(imdb_id: 1)
      
      assert_equal 1, movie.imdb_id
      assert_equal 'Carmencita', movie.title
      assert_match /imdb.com\/title\/tt0000001/, movie.link
      assert_match /ia.media-imdb.com/, movie.poster_link
      assert_equal "William K.L. Dickson", movie.director
      assert_match /Carmencita does a dance/, movie.short_description
      assert_same_elements %w(Documentary Short), movie.genres.collect { |g| g.name }
    end

    should "init movie without a database call" do
      IMDB::Search.expects(:by_id).never
      Movie.initialize_from_imdb(movie: {'imdb_id' => 'tt0000001'})
    end

    should "raise MovieNotFound if not given a movie or an imdb_id" do
      assert_raises MovieNotFound do
        Movie.initialize_from_imdb(crap: 'a bunch')
      end
    end
  end

  should "not save without list" do
    assert_raises ActiveRecord::RecordInvalid do
      FactoryGirl.create(:movie)
    end
  end
  
end
