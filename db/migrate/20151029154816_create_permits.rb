class CreatePermits < ActiveRecord::Migration
  def change
    create_table :permits do |t|
      t.string :name
      t.text :description
      t.string :type
      t.integer :hours
      t.date :start
      t.date :end

      t.timestamps null: false
    end
  end
end
