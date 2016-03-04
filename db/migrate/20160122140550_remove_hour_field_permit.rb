class RemoveHourFieldPermit < ActiveRecord::Migration
  def change
  	remove_column :permits, :hours
  	add_column :permits, :reason, :string
  end
end
