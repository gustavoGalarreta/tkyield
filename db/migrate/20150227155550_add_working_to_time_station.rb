class AddWorkingToTimeStation < ActiveRecord::Migration
  def change
  	add_column :time_stations, :working, :boolean
  end
end
