class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
