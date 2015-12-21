class ScheduleBase < ActiveRecord::Migration
  def change
    create_table :schedule_bases do |t|
      t.integer  :schedule_id, null: false
    	t.string :name, null: false
      t.date :start
      t.date :finish

      t.timestamps null: false
    end
  end
end
