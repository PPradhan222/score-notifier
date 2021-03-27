module Spiders
  class RecentMatchesSpider < ApplicationSpider
    @name = "recent_matches_spider"
    @start_urls = []
    @config = {}
    @@recent_matches = {}

    def self.process(url)
      @start_urls << url
      self.crawl!
    end

    def self.close_spider
      WebScrapper::UpdateMatchesStatus.new(@@recent_matches).call if completed?
    end

    def parse(response, url:, data: {})
      recent_matches = response.xpath(".//div[@ng-show=\"active_match_type == 'international-tab'\"]/div[contains(@class, \"cb-mtch-lst\")]")
      @@recent_matches = recent_matches_ids_and_results(recent_matches)
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