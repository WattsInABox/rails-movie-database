require 'imdb'

class Movie < ActiveRecord::Base
  attr_accessible :imdb_id, :title, :link, :poster_link, 
    :release_date, :director, :genres, :short_description

  has_many :movie_genres
  has_many :genres, through: :movie_genres

  has_many :movie_lists
  has_many :lists, through: :movie_lists
  
  validates_uniqueness_of :imdb_id

  def self.search(param)
    ::Imdb::Search.new(param).movies.first(10)
  end

  def self.initialize_from_imdb(imdb_id)
    their_movie = ::Imdb::Movie.new(imdb_id)
    our_movie = new(
      imdb_id: imdb_id,
      title: their_movie.title,
      link: their_movie.url,
      poster_link: their_movie.poster,
      release_date: their_movie.release_date,
      director: their_movie.director,
      short_description: their_movie.tagline
    )

    their_movie.genres.collect do |g| 
      our_movie.genres.new(name: g.strip)
    end

    our_movie
  end
end
