module WebScrapper
  class ScrapeUpcomingMatchesTeamSquad
    attr_reader :matches

    def initialize(matches)
      @matches = matches
    end

    def call
      upcoming_matches
      matches.each do |match|
        sleep 3
        url = "https://www.cricbuzz.com/cricket-match-facts/" + match.web_match_url
        result = Spiders::UpdateTeamSquadMembersSpider.parse!(:parse, url: url)
        WebScrapper::CreateTeamSquadMembers.new(result, match).call if result
      end
      
    end

    def upcoming_matches
      matches.each do |match|
        match.destroy if match.date_time.before?(Time.now)
      end
    end
  end
end