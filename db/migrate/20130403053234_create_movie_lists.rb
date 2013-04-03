class CreateMovieLists < ActiveRecord::Migration
  def change
    create_table :movie_lists do |t|
      t.integer :movie_id
      t.integer :list_id

      t.timestamp
    end
  end
end
