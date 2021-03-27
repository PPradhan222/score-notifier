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
        result = Spiders::GetTeamSquadMembersSpider.parse!(:parse, url: url)
        WebScrapper::CreateTeamSquadMembers.new(result, match).call if result
      end
    end

    private

    def update_matches
      matches.each do |match|
        # will write code of status live or recent later
        match.live! if match.date_time.before?(Time.now)
        match.live! if (2..5).include? match.day
      end
    end
  end
end