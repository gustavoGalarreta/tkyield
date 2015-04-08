class CreateUserAccounts < ActiveRecord::Migration
  def change
    create_table :user_accounts, id: false do |t|
      t.integer :user_id,         null: false
      t.integer :account_id,      null: false

      t.timestamps null: false
    end
  end
end
