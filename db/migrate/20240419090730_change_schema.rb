class ChangeSchema < ActiveRecord::Migration[7.0]
  def change
    drop_table :quests
    drop_table :ques
    drop_table :users

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

    add_foreign_key "quest_tags", "quests"
    add_foreign_key "quest_tags", "tags"
    add_foreign_key "tasks", "quests"
  end
end
