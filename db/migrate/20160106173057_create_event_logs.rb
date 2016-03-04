class CreateEventLogs < ActiveRecord::Migration
  def change
    create_table :event_logs do |t|
			t.integer  :schedule_id, null: false
    	t.integer :user_id, null: false
      t.string :date
      t.string :inTime
      t.string :outTime
      t.boolean :edited
      t.boolean :launch, null: false
      t.timestamps null: false
    end
  end
end
