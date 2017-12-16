class AddLastLoginColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :last_login, :datetime
    add_column :users, :password_hash, :string
    add_column :users, :password_salt, :string
    remove_column :users, :password
  end
end
