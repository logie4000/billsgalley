class AddIsAdminToUsersTable < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :isAdmin, :int
  end
end
