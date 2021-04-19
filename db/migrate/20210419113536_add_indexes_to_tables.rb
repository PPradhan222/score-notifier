class AddIndexesToTables < ActiveRecord::Migration[6.0]
  def change
    remove_index :users, :endpoint
    add_index :users, :endpoint, unique: true
    add_index :batsman_score_notifiers, [:user_id, :batsman_match_id], unique: true
  end
end
