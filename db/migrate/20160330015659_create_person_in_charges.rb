class CreatePersonInCharges < ActiveRecord::Migration
  def change
    create_table :person_in_charges do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
