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

ActiveRecord::Schema.define(version: 2020_08_06_215601) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "team_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_achievements_on_category_id"
    t.index ["team_id"], name: "index_achievements_on_team_id"
  end

  create_table "api_keys", force: :cascade do |t|
    t.string "access_token"
    t.bigint "service_app_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "session_token"
    t.index ["service_app_id"], name: "index_api_keys_on_service_app_id"
  end

  create_table "arrangement_members", force: :cascade do |t|
    t.bigint "member_id"
    t.bigint "arrangement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["arrangement_id"], name: "index_arrangement_members_on_arrangement_id"
    t.index ["member_id"], name: "index_arrangement_members_on_member_id"
  end

  create_table "arrangements", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "amount"
    t.integer "sponsorship_type"
    t.bigint "sponsor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sponsor_id"], name: "index_arrangements_on_sponsor_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "reference_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "component_categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "components", force: :cascade do |t|
    t.string "name"
    t.bigint "component_category_id"
    t.string "img_path"
    t.integer "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["component_category_id"], name: "index_components_on_component_category_id"
  end

  create_table "event_members", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_members_on_event_id"
    t.index ["member_id"], name: "index_event_members_on_member_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text "description"
    t.bigint "sponsor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sponsor_id"], name: "index_events_on_sponsor_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "first_name"
    t.string "fathers_last_name"
    t.string "mothers_last_name"
    t.string "email"
    t.integer "major"
    t.string "avatar"
    t.string "github_username"
    t.string "github_url"
    t.string "linkedin_username"
    t.string "linkedin_url"
    t.string "resume_url"
    t.integer "status"
    t.integer "role"
    t.text "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "generation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "token"
    t.index ["token"], name: "index_members_on_token", unique: true
    t.index ["username"], name: "index_members_on_username", unique: true
  end

  create_table "reservation_details", force: :cascade do |t|
    t.bigint "reservation_id"
    t.bigint "component_id"
    t.boolean "returned"
    t.datetime "returned_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["component_id"], name: "index_reservation_details_on_component_id"
    t.index ["reservation_id"], name: "index_reservation_details_on_reservation_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_reservations_on_member_id"
  end

  create_table "service_apps", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "active"
    t.integer "access_api"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sponsor_contacts", force: :cascade do |t|
    t.string "first_name"
    t.string "fathers_last_name"
    t.string "mothers_last_name"
    t.string "email"
    t.string "phone_number"
    t.text "notes"
    t.bigint "sponsor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sponsor_id"], name: "index_sponsor_contacts_on_sponsor_id"
  end

  create_table "sponsors", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "avatar"
    t.string "website_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "team_members", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_team_members_on_member_id"
    t.index ["team_id"], name: "index_team_members_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "github_url"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_teams_on_category_id"
  end

  create_table "tournament_categories", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "tournament_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_tournament_categories_on_category_id"
    t.index ["tournament_id"], name: "index_tournament_categories_on_tournament_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text "description"
    t.integer "type"
    t.string "country"
    t.string "city"
    t.string "reference_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
