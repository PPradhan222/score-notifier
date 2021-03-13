module WebScrapper
  class CreateTeamSquadMembers
    attr_reader :squads, :match

    def initialize(result, match)
      @squads = result
      @match = match
    end

    def call
      squads.each do |squad|
        team = match_team(squad[:name])
        team_squad = match.team_squads.find_by(team_id: team.id) if team
        create_squad_members(squad[:profiles_tab], team_squad.id) if team_squad
      end
    end

    def match_team(name)
      match.teams.find_by(name: name)
    end

    def create_squad_members(profiles_url_tabs, team_squad_id)
      profiles_url_tabs.each do |profiles_url_tab|
        ActiveRecord::Base.transaction do
          profile_url = profiles_url_tab.text.strip
          player = Player.find_or_create_by(web_profile_url: profile_url, web_profile_id: profile_url.split("/")[-2])
          member = TeamSquadMember.find_or_create_by(player_id: player.id, team_squad_id: team_squad_id)
        end
      end
    end   
  end
end