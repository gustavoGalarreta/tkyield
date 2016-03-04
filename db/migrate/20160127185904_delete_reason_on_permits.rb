class DeleteReasonOnPermits < ActiveRecord::Migration
  def change
  	remove_column :permits, :reason

  end
end
