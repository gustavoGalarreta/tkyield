class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :schedule_id, null: false
      t.integer :last_event_log
      t.string :inTime
      t.string :outTime
      t.integer :day_of_week, null: false
      t.boolean :launch
      t.timestamps null: false
    end
  end
end
