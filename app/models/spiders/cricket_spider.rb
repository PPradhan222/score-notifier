module Spiders
  class CricketSpider < ApplicationSpider
    @name = "cricket_spider"
    @start_urls = []
    @config = {}

    def self.process(url)
      @start_urls << url
      self.crawl!
    end

    def parse(response, url:, data: {})
      international_series = []
      response.css("div.cb-rank-hdr[ng-show=\"active_match_type == 'international-tab'\"]").each do |series|
        international_series << recent_series(series)
      end

      international_series
    end

    def recent_series(series_node)
      series = {}
      series[:name] = series_node.xpath("./h2")&.text.squish
      series[:matches] = []
      series_node.xpath("./div").each do |match|
        series[:matches] << recent_matches(match)
      end

      series
    end

    def recent_matches(match_node)
      match = {}
      match[:name] = match_node.xpath("./div[1]")&.text.squish
      match[:score] = match_node.xpath("./div[2]")&.text.squish

      match
    end
  end
end