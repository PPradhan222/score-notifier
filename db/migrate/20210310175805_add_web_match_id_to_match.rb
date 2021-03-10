class AddWebMatchIdToMatch < ActiveRecord::Migration[6.0]
  def change
    add_column :matches, :web_match_id, :string
  end
end
