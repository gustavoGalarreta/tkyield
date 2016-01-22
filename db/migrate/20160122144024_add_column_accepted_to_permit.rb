class AddColumnAcceptedToPermit < ActiveRecord::Migration
  def change
  	add_column :permits, :accepted, :boolean
  end
end
