class AddTeamLeaderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :team_leader, :boolean , default: false
  end
end
