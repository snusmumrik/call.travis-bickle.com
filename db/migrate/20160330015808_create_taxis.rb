class CreateTaxis < ActiveRecord::Migration
  def change
    create_table :taxis do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :type_name

      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
