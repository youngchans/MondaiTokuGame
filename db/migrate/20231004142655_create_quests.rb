class CreateQuests < ActiveRecord::Migration[7.0]
  def change
    create_table :quests do |t|
      t.string :question
      t.string :description
      t.timestamps
    end
  end
end
