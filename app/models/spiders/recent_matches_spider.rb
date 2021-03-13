module Spiders
  class RecentMatchesSpider < ApplicationSpider
    @name = "recent_matches_spider"
    @start_urls = []
    @config = {}
    @@web_match_ids = []

    def self.process(url)
      @start_urls << url
      self.crawl!
    end

    def self.close_spider
      WebScrapper::UpdateMatchesStatus.new(@@web_match_ids).call if completed?
    end

    def parse(response, url:, data: {})
      recent_international_matches_urls = []
      recent_international_matches_urls = response.xpath(".//div[@ng-show=\"active_match_type == 'international-tab'\"]/div[contains(@class, \"cb-mtch-lst\")]//h3//@href")
      @@web_match_ids = match_web_ids(recent_international_matches_urls)
    end

    private

    def match_web_ids(match_urls)
      web_ids = []
      match_urls.each do |match_url|
        web_ids << match_url.text.strip.split("/")[-2]
      end
      web_ids
    end
  end
end