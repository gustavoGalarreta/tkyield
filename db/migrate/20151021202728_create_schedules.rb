class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
    	t.integer :user_id, null: false
    	t.boolean :current, default: false
    	t.string :name, null: false
      t.timestamps null: false
    end
  end
end
