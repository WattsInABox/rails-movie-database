require_relative '../test_helper'

class MovieTest < ActiveSupport::TestCase
  context "search" do
    should "pull up to 10 movies from the movie database" do
      assert_nothing_raised do
        Movie.search("some movie")
      end

      assert false
    end
  end

  # TODO this test should not depend on the internets
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
