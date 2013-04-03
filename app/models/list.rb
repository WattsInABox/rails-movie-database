class List < ActiveRecord::Base
  attr_accessible :color, :name

  has_many :movie_lists
  has_many :movies, through: :movie_lists
end
