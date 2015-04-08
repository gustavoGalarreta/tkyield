class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :subdomain,              null: false,  default: ""
      t.string :company_name,           null: false,  default: ""
      t.string :company_url,            null: true,   default: ""
      t.string :company_phone,          null: true,   default: ""

      t.timestamps null: false
    end

    add_index :accounts, :subdomain,            unique: true
  end
end
