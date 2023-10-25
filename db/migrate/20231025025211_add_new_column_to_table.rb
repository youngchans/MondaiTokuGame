class AddNewColumnToTable < ActiveRecord::Migration[7.0]
  def change
    add_column :quests, :owner, :integer
  end
end
