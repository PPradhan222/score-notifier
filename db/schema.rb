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

ActiveRecord::Schema.define(version: 2021_04_25_092705) do

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

  create_table "batsman_score_notifiers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "batsman_match_id", null: false
    t.bigint "match_id", null: false
    t.integer "runs_scored"
    t.integer "balls_faced"
    t.integer "fours"
    t.integer "sixes"
    t.decimal "strike_rate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["match_id"], name: "index_batsman_score_notifiers_on_match_id"
    t.index ["user_id", "batsman_match_id"], name: "index_batsman_score_notifiers_on_user_id_and_batsman_match_id", unique: true
    t.index ["user_id"], name: "index_batsman_score_notifiers_on_user_id"
  end

  create_table "batting_player_innings", force: :cascade do |t|
    t.integer "runs_scored", default: 0
    t.integer "balls_faced", default: 0
    t.integer "fours", default: 0
    t.integer "sixes", default: 0
    t.decimal "strike_rate", default: "0.0"
    t.string "wicket_status", default: "not_batted"
    t.bigint "inning_id", null: false
    t.bigint "player_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "batting_order", default: 12
    t.index ["inning_id"], name: "index_batting_player_innings_on_inning_id"
    t.index ["player_id"], name: "index_batting_player_innings_on_player_id"
  end

  create_table "bowling_player_innings", force: :cascade do |t|
    t.integer "runs_conceded", default: 0
    t.integer "balls_bowled"
    t.integer "wickets_taken", default: 0
    t.integer "maiden_overs", default: 0
    t.decimal "economy_rate", default: "0.0"
    t.decimal "overs", default: "0.0"
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
    t.integer "inning_number"
    t.decimal "overs"
    t.index ["match_id", "inning_number"], name: "index_innings_on_match_id_and_inning_number", unique: true
    t.index ["match_id"], name: "index_innings_on_match_id"
  end

  create_table "matches", force: :cascade do |t|
    t.string "name"
    t.string "series_name"
    t.string "level"
    t.string "venue"
    t.datetime "date_time"
    t.string "web_match_url"
    t.string "result"
    t.string "toss"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "web_match_id"
    t.integer "status"
    t.string "format"
    t.string "team1_name"
    t.string "team2_name"
  end

  create_table "notification_data", force: :cascade do |t|
    t.string "endpoint"
    t.string "p256dh_key"
    t.string "auth_key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "role"
    t.string "web_profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "batting_style"
    t.string "bowling_style"
    t.string "web_profile_url"
  end

  create_table "team_squad_members", force: :cascade do |t|
    t.string "status"
    t.bigint "player_id", null: false
    t.bigint "team_squad_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "player_profile_id"
    t.index ["player_id", "team_squad_id"], name: "index_team_squad_members_on_player_id_and_team_squad_id", unique: true
    t.index ["player_id"], name: "index_team_squad_members_on_player_id"
    t.index ["team_squad_id"], name: "index_team_squad_members_on_team_squad_id"
  end

  create_table "team_squads", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "team_id", null: false
    t.string "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["match_id"], name: "index_team_squads_on_match_id"
    t.index ["team_id"], name: "index_team_squads_on_team_id"
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "notif_id"
    t.string "endpoint", null: false
    t.string "p256dh", null: false
    t.string "auth", null: false
    t.index ["endpoint"], name: "index_users_on_endpoint", unique: true
  end

  add_foreign_key "balls", "innings"
  add_foreign_key "batsman_score_notifiers", "matches"
  add_foreign_key "batsman_score_notifiers", "users"
  add_foreign_key "batting_player_innings", "innings"
  add_foreign_key "batting_player_innings", "players"
  add_foreign_key "bowling_player_innings", "innings"
  add_foreign_key "bowling_player_innings", "players"
  add_foreign_key "innings", "matches"
  add_foreign_key "team_squad_members", "players"
  add_foreign_key "team_squad_members", "team_squads"
  add_foreign_key "team_squads", "matches"
  add_foreign_key "team_squads", "teams"
end
