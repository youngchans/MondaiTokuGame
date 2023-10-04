class CreateQues < ActiveRecord::Migration[7.0]
  def change
    create_table :ques do |t|
      t.string :question
      t.string :description
      t.string :wrong_f
      t.string :wrong_s
      t.timestamps
    end
  end
end
