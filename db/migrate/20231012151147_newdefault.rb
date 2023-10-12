class Newdefault < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :highest_rate, 0
  end
end
