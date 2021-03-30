class AddPlayerProfileIdToTeamSquadMember < ActiveRecord::Migration[6.0]
  def change
    add_column :team_squad_members, :player_profile_id, :string
  end
end
