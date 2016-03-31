class CreateOrdersPersonInCharges < ActiveRecord::Migration
  def change
    create_table :orders_person_in_charges do |t|
      t.references :order, index: true, foreign_key: true
      t.references :person_in_charge, index: true, foreign_key: true

      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
