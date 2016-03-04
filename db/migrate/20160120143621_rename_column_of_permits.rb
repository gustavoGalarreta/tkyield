class RenameColumnOfPermits < ActiveRecord::Migration
  def change
  	rename_column :permits, :type, :type_permits
  end
end
