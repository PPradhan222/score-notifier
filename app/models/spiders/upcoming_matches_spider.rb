module Spiders
  class UpcomingMatchesSpider < ApplicationSpider
    @name = "upcoming_matches_spider"
    @start_urls = []
    @config = {}

    def self.process(url)
      matches = self.parse!(:parse, url: url)
      WebScrapper::AddUpcomingMatches.new(matches).call if matches
    end

    def parse(response, url:, data: {})
      result = []
      match_level = url&.split("/")&.last
      response.css("div##{match_level}-list/div").first(7).each do |matches_by_date|
        date = matches_by_date.at_css('div').text
        matches_by_date.css('/div.cb-col').each do |match_node|
          result << match_data(match_node, date, match_level)
        end
      end
      result
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