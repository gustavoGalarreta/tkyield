class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer  :schedule_id, null: false
      t.string :inTime
      t.string :outTime
      t.integer :day_of_week, null: false
      
      t.timestamps null: false
    end
  end
end
