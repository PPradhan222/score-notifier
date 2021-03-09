class RenameWebMatchId < ActiveRecord::Migration[6.0]
  def change
    rename_column :matches, :web_match_id, :web_match_url
  end
end
