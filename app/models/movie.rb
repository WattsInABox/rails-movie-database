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
    ::IMDB::Search.new.movie(param).collect do |result|
      ::IMDB::Movie.new(result.imdb_id)
    end.first(10)
  end

  def self.initialize_from_imdb(imdb_id)
    their_movie = ::IMDB::Movie.new(imdb_id)
    our_movie = new(
      imdb_id: imdb_id,
      title: their_movie.title,
      link: their_movie.link,
      poster_link: their_movie.poster,
      release_date: their_movie.release_date,
      director: their_movie.director,
      short_description: their_movie.short_description
    )

    their_movie.genres.collect do |g| 
      our_movie.genres.new(name: g.strip)
    end

    our_movie
  end

  def assign_to_lists(*list_ids)
    self.lists = list_ids.collect { |list_id| List.find(list_id) }
    self.save
  end
end


# IMDB overrides
# TODO request a pull
module IMDB
  class Movie < IMDB::Skeleton
    # Get movie poster address
    # @return [String]
    def poster
      doc.at("#img_primary img").try(:[], "src")
    end

    # @return [String]
    def short_description
      doc.at("#overview-top p[itemprop=description]").try(:text).try(:strip)
    end
  end
end
