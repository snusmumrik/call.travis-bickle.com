class AddLocationToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :location, :string, after: :user_id
  end
end
