module Spiders
  class RecentMatchesSpider < ApplicationSpider
    @name = "recent_matches_spider"
    @start_urls = []
    @config = {}

    def self.process(url)
      recent_matches = self.parse!(:parse, url: url)
      WebScrapper::UpdateMatchesStatus.new(recent_matches).call if recent_matches
    end

    def parse(response, url:, data: {})
      international_recent_matches = response.xpath(".//div[@ng-show=\"active_match_type == 'international-tab'\"]/div[contains(@class, \"cb-mtch-lst\")]")
      league_recent_matches = response.xpath(".//div[@ng-show=\"active_match_type == 'league-tab'\"]/div[contains(@class, \"cb-mtch-lst\")]")
      recent_matches = international_recent_matches + league_recent_matches
      recent_matches_ids_and_results(recent_matches)
    end

    private

    def recent_matches_ids_and_results(recent_matches)
      matches = {}
      recent_matches.each do |recent_match|
       web_match_id = recent_match.xpath('.//h3//@href').text.strip.split("/")&.dig(-2)
       matches[web_match_id] = recent_match.xpath('.//div[contains(@class, "cb-text-complete")]').text.strip
      end
      matches
    end
  end
end