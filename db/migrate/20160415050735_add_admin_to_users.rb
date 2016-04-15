class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, after: :authentication_token
  end
end
