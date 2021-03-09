# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_09_065830) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "balls", force: :cascade do |t|
    t.integer "ball_number"
    t.integer "over_number"
    t.string "ball_type"
    t.integer "run"
    t.string "run_type"
    t.boolean "wicket"
    t.string "wicket_type"
    t.bigint "inning_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["inning_id"], name: "index_balls_on_inning_id"
  end

  create_table "batting_player_innings", force: :cascade do |t|
    t.integer "runs_scored"
    t.integer "balls_faced"
    t.integer "fours"
    t.integer "sixes"
    t.decimal "strike_rate"
    t.string "wicket_status"
    t.bigint "inning_id", null: false
    t.bigint "player_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["inning_id"], name: "index_batting_player_innings_on_inning_id"
    t.index ["player_id"], name: "index_batting_player_innings_on_player_id"
  end

  create_table "bowling_player_innings", force: :cascade do |t|
    t.integer "runs_conceded"
    t.integer "balls_bowled"
    t.integer "wickets_taken"
    t.integer "maiden_overs"
    t.decimal "economy_rate"
    t.decimal "overs"
    t.bigint "inning_id", null: false
    t.bigint "player_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["inning_id"], name: "index_bowling_player_innings_on_inning_id"
    t.index ["player_id"], name: "index_bowling_player_innings_on_player_id"
  end

  create_table "innings", force: :cascade do |t|
    t.string "name"
    t.integer "runs"
    t.integer "wickets"
    t.string "status"
    t.bigint "match_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["match_id"], name: "index_innings_on_match_id"
  end

  create_table "match_teams", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "team_id", null: false
    t.string "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["match_id"], name: "index_match_teams_on_match_id"
    t.index ["team_id"], name: "index_match_teams_on_team_id"
  end

  create_table "matches", force: :cascade do |t|
    t.string "name"
    t.string "series_name"
    t.string "format"
    t.string "level"
    t.string "venue"
    t.datetime "date_time"
    t.string "status"
    t.string "web_match_id"
    t.string "result"
    t.string "toss"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "role"
    t.string "web_profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "level"
    t.string "web_team_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "abbreviated_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "balls", "innings"
  add_foreign_key "batting_player_innings", "innings"
  add_foreign_key "batting_player_innings", "players"
  add_foreign_key "bowling_player_innings", "innings"
  add_foreign_key "bowling_player_innings", "players"
  add_foreign_key "innings", "matches"
  add_foreign_key "match_teams", "matches"
  add_foreign_key "match_teams", "teams"
end
