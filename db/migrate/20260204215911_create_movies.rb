class CreateMovies < ActiveRecord::Migration[8.0]
  def change
    create_table :movies do |t|
      t.integer :tmdb_id
      t.string :title
      t.text :synopsis
      t.string :poster_url
      t.string :backdrop_url
      t.date :release_date
      t.string :genres
      t.string :trailer_key
      t.text :cached_data

      t.timestamps
    end
  end
end
