class AddParentIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :parent_id, :integer, index: true, foreign_key: true, after: :id
  end
end
