class ChangeAcceptedColumnOnPermits < ActiveRecord::Migration
  def change
  	remove_column :permits, :accepted
  	add_column :permits, :status, :integer
  end
end
