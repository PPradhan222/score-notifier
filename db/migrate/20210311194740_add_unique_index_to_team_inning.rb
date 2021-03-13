class AddUniqueIndexToTeamInning < ActiveRecord::Migration[6.0]
  def change
    add_index :innings, [:match_id, :inning_number], unique: true
  end
end
