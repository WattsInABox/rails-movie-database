require_relative '../test_helper'

class GenreTest < ActiveSupport::TestCase

  should "save" do
    genre = Genre.new(FactoryGirl.attributes_for(:genre))
    assert_equal true, genre.save
  end

  should "save with movie" do
  end
  
end
