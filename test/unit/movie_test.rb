require_relative '../test_helper'

# TODO this test should not depend on the internets
class MovieTest < ActiveSupport::TestCase
  context "search" do
    should "pull up to 10 movies from the movie database" do
      movies = Movie.search("top gear")

      assert_equal 10, movies.length
      assert_instance_of Imdb::Movie, movies.first
    end
  end

  context "initializing from Imdb" do
    should "init movie with genres and lists" do
      movie = Movie.initialize_from_imdb(1)
      
      assert_equal true, movie.save
      assert_equal 1, Movie.count

      assert_equal 1, movie.reload.imdb_id
      assert_equal 'Carmencita', movie.title
      assert_equal 'http://akas.imdb.com/title/tt1/combined', movie.link
      assert_same_elements %w(Documentary Short), movie.genres.collect { |g| g.name }
    end
  end
  
end
