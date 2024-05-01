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

ActiveRecord::Schema[7.0].define(version: 2024_04_23_021036) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "quest_tags", force: :cascade do |t|
    t.bigint "quest_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quest_id"], name: "index_quest_tags_on_quest_id"
    t.index ["tag_id"], name: "index_quest_tags_on_tag_id"
  end

  create_table "quests", force: :cascade do |t|
    t.string "question"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "owner"
  end

  create_table "tags", force: :cascade do |t|
    t.string "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "similar_word"
    t.boolean "completed"
    t.bigint "quest_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quest_id"], name: "index_tasks_on_quest_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.integer "highest_rate", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "birth_date"
  end

  add_foreign_key "quest_tags", "quests", on_delete: :cascade
  add_foreign_key "quest_tags", "tags"
  add_foreign_key "tasks", "quests"
end
