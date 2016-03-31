class CreateOrdersTaxis < ActiveRecord::Migration
  def change
    create_table :orders_taxis do |t|
      t.references :order
      t.references :taxi, index: true, foreign_key: true

      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
