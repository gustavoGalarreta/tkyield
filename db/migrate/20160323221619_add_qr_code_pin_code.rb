class AddQrCodePinCode < ActiveRecord::Migration
  def change
  	add_column :users, :qr_code, :string
  	add_column :users, :pin_code, :string
  end
end
