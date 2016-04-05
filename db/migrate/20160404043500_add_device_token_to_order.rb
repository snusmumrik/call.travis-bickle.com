class AddDeviceTokenToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :device_token, :string, after: :keyword
  end
end
