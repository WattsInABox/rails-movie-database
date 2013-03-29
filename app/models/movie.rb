require 'imdb'

class Movie < ActiveRecord::Base
  # has_many :genres
  attr_accessible :imdb_id, :title, :link, :poster_link, 
    :release_date, :director, :genres, :short_description

  def self.search(param)
    ::IMDB::Search.new.movie(param).collect do |result|
      ::IMDB::Movie.new(result.imdb_id)
    end
  end

  def self.save_from_imdb(imdb_id)
    movie = ::IMDB::Movie.new(imdb_id)
    self.create(
      imdb_id: imdb_id,
      title: movie.title,
      link: movie.link,
      poster_link: movie.poster,
      release_date: movie.release_date,
      director: movie.director,
      genres: movie.genres.join(','),
      short_description: movie.short_description
    )
  end
end
