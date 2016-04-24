class AddAmountAndTimeToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :amount, :integer, after: :longitude
    add_column :orders, :time, :datetime, after: :amount
  end
end
