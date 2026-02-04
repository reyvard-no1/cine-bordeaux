# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2026_02_04_220005) do
  create_table "movies", force: :cascade do |t|
    t.integer "tmdb_id"
    t.string "title"
    t.text "synopsis"
    t.string "poster_url"
    t.string "backdrop_url"
    t.date "release_date"
    t.string "genres"
    t.string "trailer_key"
    t.text "cached_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wishlists", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "movie_id", null: false
    t.boolean "notified"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_wishlists_on_movie_id"
    t.index ["user_id"], name: "index_wishlists_on_user_id"
  end

  add_foreign_key "wishlists", "movies"
  add_foreign_key "wishlists", "users"
end
