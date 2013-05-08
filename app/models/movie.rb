require 'imdb'

MovieNotFound  = Class.new(ArgumentError)

class Movie < ActiveRecord::Base
  attr_accessible :imdb_id, :title, :link, :poster_link, 
    :release_date, :director, :genres, :short_description

  has_many :movie_genres
  has_many :genres, through: :movie_genres

  has_many :movie_lists
  has_many :lists, through: :movie_lists
  
  validates_uniqueness_of :imdb_id
  validates :lists, length: { minimum: 1 }

  def self.search(param)
    ::IMDB::Search.by_title(param, { limit: 10 }).collect { |m| initialize_from_imdb(movie: m) }
  end

  # can optionally pass in the movie from IMDB already initialized (say from search by_title)
  def self.initialize_from_imdb(options={})
    their_movie = options[:movie] || ::IMDB::Search.by_id(options[:imdb_id])

    raise MovieNotFound  if their_movie['code'].try(:to_i).try(:>, 200)

    our_movie = new(
      imdb_id: their_movie['imdb_id'].rpartition('tt')[2],
      title: their_movie['title'],
      link: their_movie['imdb_url'],
      poster_link: their_movie['poster'],
      # release_date: their_movie['release_date'], # TODO remove release_date since IMDB API does not have this field
      director: Array(their_movie['directors']).first,
      short_description: their_movie['plot_simple']
    )

    Array(their_movie['genres']).collect do |g| 
      our_movie.genres.new(name: g.strip)
    end

    our_movie
  end

  def label
    "#{title}: #{short_description}"
  end
end
