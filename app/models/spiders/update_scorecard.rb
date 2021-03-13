module Spiders
  class UpdateScorecard < ApplicationSpider
    @name = "update_scorecard"
    @start_urls = []
    @config = {}
    @@result = { match: nil, innings: [] }

    def self.process(url, match)
      @start_urls << url
      @@result[:match] = match
      self.crawl!
    end

    def self.close_spider
      if completed?
        WebScrapper::UpdateInnings.new(@@result[:innings], @@result[:match]).call
      end
    end

    def parse(response, url:, data: {})
      inning_tabs = response.xpath('//div[starts-with(@id, "innings")]')
      inning_tabs.each do |inning_tab|
        @@result[:innings] << fill_inning(inning_tab)
      end
    end

    def fill_inning(inning_tab)
      inning = {}
      inning[:inning_number] = inning_tab.xpath('./@id').text.split("_").last.to_i
      inning[:name] = inning_tab.css('div.cb-scrd-hdr-rw').text.strip
      score = inning[:name].split("Innings").last.strip
      inning[:runs] = runs(score)
      inning[:wickets] = wickets(score)
      inning[:overs] = overs(score)
      inning[:status] = "declared" if score.include?('d')
      inning[:batting_card] = batting_card(inning_tab)
      inning[:bowling_card] = bowling_card(inning_tab)
      inning
    end

    def runs(score)
      score.split("-").first.to_i
    end

    def wickets(score)
      score.split(" ").first.split("-").second.to_i
    end

    def overs(score)
      score.split("(").last.split(" ").first.to_f
    end

    def batting_card(inning_tab)
      batsmen_tab = inning_tab.xpath(".//div[contains(@class, 'cb-scrd-itms')]//div[contains(text(), 'Total')]/../preceding-sibling::div//a[contains(@href, '/profile')]/../..")
      did_not_bat = inning_tab.xpath(".//div[contains(@class, 'cb-scrd-itms')]//div[contains(text(), 'Total')]/../following-sibling::div//a[contains(@href, '/profile')]")
      batting_info(batsmen_tab, did_not_bat)
    end

    def batting_info(batsmen_tab, did_not_bat)
      batting_card = []
      batsmen_tab.each do |batsman_tab|
        batsman = {}
        batsman[:profile_url] = batsman_tab.xpath(".//a[contains(@href, '/profile')]/@href").text.strip
        batsman_desc = batsman_tab.text.strip.split(" ")
        batsman[:strike_rate] = batsman_desc.pop.to_f
        batsman[:sixes] = batsman_desc.pop.to_i
        batsman[:fours] = batsman_desc.pop.to_i
        batsman[:balls_faced] = batsman_desc.pop.to_i
        batsman[:runs_scored] = batsman_desc.pop.to_i
        batsman[:wicket_status] = batsman_tab.xpath('.//span[@class="text-gray"]').text.strip
        batting_card << batsman
      end

      did_not_bat.each do |batsman_tab|
        batsman = {}
        batsman[:profile_url] = batsman_tab.xpath('@href').text.strip
        batting_card << batsman
      end
      batting_card
    end

    def bowling_card(inning_tab)
      bowling_card = []
      bowlers_tab = inning_tab.xpath(".//div[contains(@class, 'cb-ltst-wgt-hdr')][2]/div[contains(@class, 'cb-scrd-itms')]")
      bowlers_tab.each do |bowler_tab|
        bowler = {}
        bowler[:profile_url] = bowler_tab.xpath(".//a[contains(@href, '/profile')]/@href").text.strip
        bowler_desc = bowler_tab.text.strip.split(" ")
        bowler[:runs_conceded] = bowler_desc[-5].to_i
        bowler[:wickets_taken] = bowler_desc[-4].to_i
        bowler[:maiden_overs] = bowler_desc[-6].to_i
        bowler[:economy_rate] = bowler_desc[-1].to_f
        bowler[:overs] = bowler_desc[-7].to_f
        bowling_card << bowler
      end
      bowling_card
    end

    # def overs_to_ball(overs_string)
    #   overs = overs_string.split(".")
    #   (overs.first.to_i * 6) + overs.second.to_i
    # end
  end
end
