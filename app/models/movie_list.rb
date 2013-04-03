class MovieList < ActiveRecord::Base
  belongs_to :movie
  belongs_to :list
end