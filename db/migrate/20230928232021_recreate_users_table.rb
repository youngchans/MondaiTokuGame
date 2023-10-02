class RecreateUsersTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :users # 테이블 삭제

    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.integer :highest_rate
      t.timestamps
    end
  end

  def down
    drop_table :users # 롤백 시 테이블 삭제
  end
end