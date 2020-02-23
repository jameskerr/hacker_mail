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

ActiveRecord::Schema.define(version: 2020_02_14_041643) do

  create_table "samples", force: :cascade do |t|
    t.datetime "ts"
    t.integer "score"
    t.integer "story_id", null: false
    t.index ["story_id"], name: "index_samples_on_story_id"
    t.index ["ts"], name: "index_samples_on_ts"
  end

  create_table "sent_stories", id: false, force: :cascade do |t|
    t.integer "subscriber_id"
    t.integer "story_id"
    t.index ["story_id"], name: "index_sent_stories_on_story_id"
    t.index ["subscriber_id"], name: "index_sent_stories_on_subscriber_id"
  end

  create_table "stories", force: :cascade do |t|
    t.string "title", null: false
    t.string "url", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subscribers", force: :cascade do |t|
    t.string "email"
    t.integer "threshold"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_subscribers_on_email", unique: true
  end

  add_foreign_key "samples", "stories"
  add_foreign_key "sent_stories", "stories"
  add_foreign_key "sent_stories", "subscribers"
end
