# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_12_31_042130) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "main_addresses", force: :cascade do |t|
    t.bigint "user_id"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.float "longitude"
    t.float "latitude"
    t.index ["user_id"], name: "index_main_addresses_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string "url"
    t.bigint "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_photos_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.float "longitude"
    t.float "latitude"
    t.string "yelp_id"
    t.string "yelp_link"
    t.string "yelp_rating"
    t.integer "yelp_reviews"
    t.string "phone_number"
    t.string "address"
    t.string "name"
    t.string "image"
    t.string "city"
    t.string "yelp_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title"
    t.integer "rating"
    t.text "review"
    t.bigint "user_id"
    t.bigint "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_reviews_on_restaurant_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
  end

  create_table "visits", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_visits_on_restaurant_id"
    t.index ["user_id"], name: "index_visits_on_user_id"
  end

  create_table "wishlists", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "restaurant_id"
    t.index ["restaurant_id"], name: "index_wishlists_on_restaurant_id"
    t.index ["user_id"], name: "index_wishlists_on_user_id"
  end

  add_foreign_key "main_addresses", "users"
  add_foreign_key "photos", "restaurants"
  add_foreign_key "reviews", "restaurants"
  add_foreign_key "reviews", "users"
  add_foreign_key "visits", "restaurants"
  add_foreign_key "visits", "users"
  add_foreign_key "wishlists", "restaurants"
  add_foreign_key "wishlists", "users"
end
