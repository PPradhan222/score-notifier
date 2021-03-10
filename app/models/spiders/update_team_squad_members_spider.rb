module Spiders
  class UpdateTeamSquadMembersSpider < ApplicationSpider
    @name = "update_team_squad_members_spider.rb"
    @engine = :mechanize
    @start_urls = []
    @config = {}

    def parse(response, url:, data: {})
      match_info_tab = response.xpath("//div[contains(text(), 'Match Info')]/following-sibling::div[1]")
      total_squad_teams = match_info_tab.xpath("//div[contains(text(), 'Squad:')]").count
      squad_tabs = match_info_tab.xpath("//div[contains(text(), 'Squad:')]")
      total_profiles = squad_tabs.xpath('following-sibling::div//a[starts-with(@href, "/profile")]').count
      return nil if total_profiles == 0
      second_team_profiles = squad_tabs.last.xpath('following-sibling::div//a[starts-with(@href, "/profile")]').count
      first_team_profiles = total_profiles - second_team_profiles
      teams = []
      if total_squad_teams > 0
        team = {}
        team[:profiles_tab] = []
        team[:name] = squad_tabs.first.text.chomp("Squad:")[0..-2].downcase
        team[:profiles_tab] = squad_tabs.first.xpath('following-sibling::div//a[starts-with(@href, "/profile")]/@href')[0..(first_team_profiles - 1)]
        teams << team
      end
      if total_squad_teams > 1
        team = {}
        team[:profiles_tab] = []
        team[:name] = squad_tabs.last.text.chomp("Squad:")[0..-2].downcase
        team[:profiles_tab] = squad_tabs.last.xpath('following-sibling::div//a[starts-with(@href, "/profile")]/@href')
        teams << team
      end
    end
  end
end
