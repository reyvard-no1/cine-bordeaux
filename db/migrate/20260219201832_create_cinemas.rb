class CreateCinemas < ActiveRecord::Migration[8.0]
  def change
    create_table :cinemas do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :postal_code
      t.string :phone
      t.string :website
      t.decimal :latitude
      t.decimal :longitude
      t.text :description

      t.timestamps
    end
  end
end
