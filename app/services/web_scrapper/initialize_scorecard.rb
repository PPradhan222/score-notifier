module WebScrapper
  class InitializeScorecard
    attr_reader :scorecard

    def initialize(result)
      @scorecard = result
    end

    def call
      match = scorecard[:match]
      return unless match
      match.update(toss: scorecard[:toss])
      scorecard[:teams].each do |team_profile|
        team = find_team(match, team_profile)
        update_team_squad_members(match, team, team_profile)
      end
    end

    def find_team(match, team_profile)
      match.teams.find_by(name: team_profile[:name])
    end

    def update_team_squad_members(match, team, team_profile)
      team_squad = match.team_squads.find_by(team_id: team.id) if team
      squad_members = team_squad&.team_squad_members
      team_profile[:profiles][:playing].each do |url|
        player = team_squad&.players.find_by(web_profile_id: url.text)
        team_squad&.team_squad_members.find_by(player_id: player.id)&.update(status: 'playing')
      end
      team_profile[:profiles][:bench].each do |url|
        player = team_squad&.players.find_by(web_profile_id: url.text)
        team_squad&.team_squad_members.find_by(player_id: player.id)&.update(status: 'bench')
      end
    end
  end
end