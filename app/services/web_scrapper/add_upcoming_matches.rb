module WebScrapper
  class AddUpcomingMatches
    attr_reader :matches

    def initialize(matches)
      @matches = matches
    end

    def call
      # check if threading can be done here
      matches.each do |match|
        match[:format] = match_format(match[:name])
        match[:web_match_url] = web_match_url(match[:web_match_url])
        match[:web_match_id] = web_match_id(match[:web_match_url])
        match[:status] = 'upcoming'
        teams = teams(match[:name])
        create_matches(match,teams.first, teams.second)
        # update matches to destroy matches which has moved to live or completed
      end
    end

    def create_matches(match, first_team, second_team)
      ActiveRecord::Base.transaction do
        current_match = Match.find_or_create_by(match)
        TeamSquad.find_or_create_by(match_id: current_match.id, team_id: first_team.id) if first_team
        TeamSquad.find_or_create_by(match_id: current_match.id, team_id: second_team.id) if second_team
      end
    end

    def teams(match_name)
      teams = match_name.split(",").first.split("vs")
      first_team = teams.first.strip.downcase
      second_team = teams.second.strip.downcase
      first_team = Team.find_by(name: first_team)
      second_team = Team.find_by(name: second_team)

      [first_team, second_team]
    end

    def  match_format(match_name)
      format_string = match_name.split(",").second.downcase
      ['t20', 'odi', 'test'].each do |format|
        return format if format_string.include?(format)
      end
      return 'other'
    end

    def web_match_url(url_string)
      url_string.split("/").last(2).join("/")
    end

    def web_match_id(url_string)
      url_string.split("/").first
    end
  end
end