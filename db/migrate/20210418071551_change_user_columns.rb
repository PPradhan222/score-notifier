class ChangeUserColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :name, :string
    remove_column :users, :password, :string
    remove_column :users, :auth_key, :string
    remove_column :users, :email, :string
    add_column :users, :endpoint, :string, uniqueness: true
    add_column :users, :p256dh, :string
    add_column :users, :auth, :string
    add_index :users, :endpoint
  end
end
