class AddUniqueIndexToTeamSquadMember < ActiveRecord::Migration[6.0]
  def change
    add_index :team_squad_members, [:player_id, :team_squad_id], unique: true
  end
end
