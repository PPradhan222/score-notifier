module Spiders
  class InitializeScorecard < ApplicationSpider
    @name = "initialize_scorecard"
    @start_urls = []
    @config = {}
    @@result = { toss: nil, teams: [] }

    def self.process(url, match)
      start_urls << url
      @@result[:match] = match
      self.crawl!
    end

    def self.close_spider
      return unless @@result
      if completed?
        WebScrapper::InitializeScorecard.new(@@result).call
      end
    end

    def parse(response, url:, data: {})
      toss = response.at_xpath('//div[contains(text(), "Toss")]/following-sibling::div')
      return nil unless toss
      @@result[:toss] = toss.text.strip
      match_info_tab = response.xpath("//div[contains(text(), 'Match Info')]/following-sibling::div[1]")
      total_squad_teams = match_info_tab.xpath("//div[contains(text(), 'Squad:')]")&.count if match_info_tab
      squad_tabs = match_info_tab.xpath("//div[contains(text(), 'Squad:')]") if match_info_tab
      squad_tabs.each do |squad_tab|
        team = {}
        team[:name] = squad_tab.text.chomp("Squad:")[0..-2].downcase
        team[:profiles] = { playing: [], bench: [] }
        team[:profiles][:playing] = squad_tab.xpath('following-sibling::div[1]//a/@href')
        team[:profiles][:bench] = squad_tab.xpath('following-sibling::div[2]//a/@href')
        @@result[:teams] << team
      end
    end
  end
end
