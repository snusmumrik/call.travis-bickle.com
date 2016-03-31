class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :keyword
      t.datetime :assigned_at
      t.datetime :picked_up_at
      t.datetime :arrived_at

      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
