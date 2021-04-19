class AddValidationToUserColumns < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :endpoint, :string, null: false, unique: true
    change_column :users, :p256dh, :string, null: false
    change_column :users, :auth, :string, null: false
  end
end
