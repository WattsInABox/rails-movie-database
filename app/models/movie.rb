class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.integer :imdb_id
      t.string :title
      t.string :link
      t.string :poster_link
      t.date :release_date
      t.string :director
      t.string :genres
      t.string :short_description

      t.timestamps
    end
  end
end
