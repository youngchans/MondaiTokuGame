class ChangeForeignKeyConstraintOnQuestTags < ActiveRecord::Migration[7.0]
  def up
    # 既存の外部キー制約を削除
    remove_foreign_key :quest_tags, :quests

    # 外部キー制約を再作成し、ON DELETE CASCADE オプションを追加
    add_foreign_key :quest_tags, :quests, on_delete: :cascade
  end
end
