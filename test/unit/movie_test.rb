require_relative '../test_helper'

# TODO this test should not depend on the internets
class MovieTest < ActiveSupport::TestCase
  context "search" do
    should "pull up to 10 movies from the movie database" do
      movies = Movie.search("top gear")

      assert_equal 10, movies.length
      assert_instance_of IMDB::Movie, movies.first
    end
  end

  context "save_from_imdb" do
    should "save movie" do
      Movie.save_from_imdb(1)
      assert_equal 1, Movie.count

      assert_equal 1, Movie.first.imdb_id
      assert_equal 'Carmencita', Movie.first.title
      assert_equal 'http://www.imdb.com/title/tt1', Movie.first.link
    end
  end
  
end
