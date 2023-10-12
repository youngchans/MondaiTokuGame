class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :similar_word
      t.boolean :completed
      t.belongs_to :quest, null: false, foreign_key: true
      t.timestamps
    end
  end
end
