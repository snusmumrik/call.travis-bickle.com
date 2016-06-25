class AddMemoToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :memo, :string, after: :keyword
  end
end
