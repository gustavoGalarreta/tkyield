class RenameEndColumnOfPermits < ActiveRecord::Migration
  def change
  	rename_column :permits, :end, :finish
  end
end
