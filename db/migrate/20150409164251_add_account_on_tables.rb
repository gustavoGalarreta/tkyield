class AddAccountOnTables < ActiveRecord::Migration
  def change
  	add_column :clients, :account_id, :integer, null: true
  	add_column :tasks, :account_id, :integer, null: true
  	add_column :projects, :account_id, :integer, null: true
  	add_column :teams, :account_id, :integer, null: true
  end
end
