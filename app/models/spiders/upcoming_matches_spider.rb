module Spiders
  class UpcomingMatchesSpider < ApplicationSpider
    @name = "upcoming_matches_spider"
    @start_urls = []
    @config = {}
    @@matches = []

    def self.process(url)
      @start_urls << url
      self.crawl!
    end

    def self.close_spider
      if completed?
        WebScrapper::AddUpcomingMatches.new(@@matches).call
      end
    end

    def parse(response, url:, data: {})
      @@matches = []
      response.css('div#international-list/div').first(7).each do |matches_by_date|
        date = matches_by_date.at_css('div').text
        matches_by_date.css('/div.cb-col').each do |match_node|
          @@matches << match_data(match_node, date, 'international')
        end
      end
    end

    def match_data(match_node, date, level)
      match = {}
      match[:series_name] = match_node.at_css('/a').text
      match[:name] = match_node.xpath('div/div[1]/a').text
      match[:web_match_url] = match_node.xpath('div/div[1]/a/@href').text
      match[:date_time] = DateTime.parse(date + " " + match_node.xpath('div/div[2]/div/span[1]').text + " GMT")
      match[:venue] = match_node.xpath('div/div[1]/div').text
      match[:level] = level

      match
    end
  end
end