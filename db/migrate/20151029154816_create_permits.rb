class CreatePermits < ActiveRecord::Migration
  def change
    create_table :permits do |t|
      t.integer :user_id, null: false
      t.string :name
      t.text :description
      t.integer :type_permit
      t.date :start
      t.date :finish
      t.integer :status

      t.timestamps null: false
    end
  end
end
