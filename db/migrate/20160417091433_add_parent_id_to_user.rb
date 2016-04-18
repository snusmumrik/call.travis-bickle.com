class AddParentIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :parent_id, :integer, index: true, foreign_key: true, after: :id
  end
end
