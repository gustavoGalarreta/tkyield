class CreateTimesheets < ActiveRecord::Migration
  def change
    create_table :timesheets do |t|
      t.integer :user_id 
      t.integer :task_id
      t.integer :project_id
      t.datetime :start_time
      t.datetime :stop_time
      t.float :total_time
      t.string :status
      t.timestamps null: false
    end
  end
end
