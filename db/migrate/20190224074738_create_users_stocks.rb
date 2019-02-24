class CreateUsersStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :users_stocks do |t|
      t.references :user, foreign_key: true
      t.references :stocks, foreign_key: true

      t.timestamps
    end
  end
end
