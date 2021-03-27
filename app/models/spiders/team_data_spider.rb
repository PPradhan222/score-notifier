module Spiders
  class TeamDataSpider < ApplicationSpider
    @name = "team_data_spider"
    @start_urls = []
    @config = {}

    def self.process(url)
      teams = self.parse!(:parse, url: url)
      Team.create(teams) if teams
    end

    def parse(response, url:, data: {})
      result = []
      response.css('div.cb-team-item').each do |international_team|
        result << team_data(international_team, 'international')
      end
      
      ['league', 'domestic', 'women'].each do |level|
        result += request_to(:parse_teams, url: (url + "/" + level), data: data.merge(level: level))
      end
      # use in_parallel instead of request_to for different urls
      result
    end

    def team_data(team_node, level)
      team = {}
      team[:name] = team_node.xpath('h2/a').text.strip.downcase
      team[:web_team_id] = team_node.xpath('h2/a/@href').text
      team[:level] = level

      team
    end

    def parse_teams(response, url:, data: {})
      temp = []
      response.css('div.cb-team-item').each do |team|
        temp << team_data(team, data[:level])
      end

      temp
    end
  end
end
