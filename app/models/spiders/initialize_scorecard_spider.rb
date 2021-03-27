module Spiders
  class InitializeScorecardSpider < ApplicationSpider
    @name = "initialize_scorecard_spider"
    @start_urls = []
    @config = {}

    def self.process(url, match)
      scorecard = { toss: nil, teams: [] }
      scorecard[:match] = match
      result = self.parse!(:parse, url: url)
      scorecard[:toss] = result[:toss]
      scorecard[:teams] = result[:teams]
      WebScrapper::InitializeScorecard.new(scorecard).call if scorecard[:toss]
    end

    def parse(response, url:, data: {})
      result = { toss: nil, teams: [] }
      toss = response.at_xpath('//div[contains(text(), "Toss")]/following-sibling::div')
      return result unless toss
      result[:toss] = toss.text.strip
      match_info_tab = response.xpath("//div[contains(text(), 'Match Info')]/following-sibling::div[1]")
      total_squad_teams = match_info_tab.xpath("//div[contains(text(), 'Squad:')]")&.count if match_info_tab
      squad_tabs = match_info_tab.xpath("//div[contains(text(), 'Squad:')]") if match_info_tab
      squad_tabs.each do |squad_tab|
        team = {}
        team[:name] = squad_tab.text.chomp("Squad:")[0..-2].downcase
        team[:profiles] = { playing: [], bench: [] }
        team[:profiles][:playing] = squad_tab.xpath('following-sibling::div[1]//a/@href')
        team[:profiles][:bench] = squad_tab.xpath('following-sibling::div[2]//a/@href')
        result[:teams] << team
      end
      result
    end
  end
end
