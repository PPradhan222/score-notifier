class RenameMatchTeamToTeamSquad < ActiveRecord::Migration[6.0]
  def change
    rename_table :match_teams, :team_squads
  end
end
