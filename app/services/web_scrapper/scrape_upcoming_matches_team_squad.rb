module WebScrapper
  class ScrapeUpcomingMatchesTeamSquad
    attr_reader :matches

    def initialize(matches)
      @matches = matches
    end

    def call
      update_matches
      matches.each do |match|
        sleep 3
        url = "https://www.cricbuzz.com/cricket-match-facts/" + match.web_match_url
        result = Spiders::UpdateTeamSquadMembersSpider.parse!(:parse, url: url)
        WebScrapper::CreateTeamSquadMembers.new(result, match).call if result
      end
      
    end

    def update_matches
      matches.each do |match|
        # will write code of status live or recent later
        match.update(status: 'other') if match.date_time.before?(Time.now)
      end
    end
  end
end