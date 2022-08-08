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

ActiveRecord::Schema.define(version: 2022_08_08_024203) do

  create_table "discounts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "code"
    t.float "rate"
    t.decimal "condition", precision: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "genres", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "movies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "release_date"
    t.time "duration"
    t.string "language"
    t.string "cast"
    t.string "director"
    t.boolean "status"
    t.bigint "genre_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genre_id"], name: "index_movies_on_genre_id"
  end

  create_table "payments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.decimal "total", precision: 10
    t.boolean "status"
    t.bigint "user_id"
    t.bigint "discount_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["discount_id"], name: "index_payments_on_discount_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "ratings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "comment"
    t.float "rate"
    t.boolean "favorite"
    t.bigint "user_id"
    t.bigint "movie_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_ratings_on_movie_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "rooms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.integer "total_seat"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "seats", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "type"
    t.decimal "price", precision: 10
    t.bigint "room_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_id"], name: "index_seats_on_room_id"
  end

  create_table "shows", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "date"
    t.time "start_time"
    t.bigint "movie_id"
    t.bigint "room_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_shows_on_movie_id"
    t.index ["room_id"], name: "index_shows_on_room_id"
  end

  create_table "tickets", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.decimal "price", precision: 10
    t.bigint "show_id"
    t.bigint "payment_id"
    t.bigint "seat_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["payment_id"], name: "index_tickets_on_payment_id"
    t.index ["seat_id"], name: "index_tickets_on_seat_id"
    t.index ["show_id"], name: "index_tickets_on_show_id"
  end

  create_table "user_discounts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "discount_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["discount_id"], name: "index_user_discounts_on_discount_id"
    t.index ["user_id"], name: "index_user_discounts_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.date "date_of_birth"
    t.string "email"
    t.string "password_digest"
    t.string "phone_number"
    t.integer "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "movies", "genres"
  add_foreign_key "payments", "discounts"
  add_foreign_key "payments", "users"
  add_foreign_key "ratings", "movies"
  add_foreign_key "ratings", "users"
  add_foreign_key "seats", "rooms"
  add_foreign_key "shows", "movies"
  add_foreign_key "shows", "rooms"
  add_foreign_key "tickets", "payments"
  add_foreign_key "tickets", "seats"
  add_foreign_key "tickets", "shows"
  add_foreign_key "user_discounts", "discounts"
  add_foreign_key "user_discounts", "users"
end
