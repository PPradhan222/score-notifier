module Notification
  class SendBatsmanNotification
    attr_reader :match_key, :batsmen_scorecard_data

    def initialize(match_key)
      @match_key = match_key
      @batsmen_scorecard_data = []
    end

    def call
      return unless $redis.exists? match_key
      batsmen_scorecard
      Notification::SendPlayerRunsNotification.new(batsmen_scorecard_data.pluck(:web_profile_id, :runs_scored)).call
    end

    private

    def batsmen_scorecard
      match_data = JSON.parse $redis.get match_key
      match_data["innings"].each do |inning_data|
        inning_data["batting_card"].each do |batsman_data|
          next unless batsman_data["wicket_status"] == "batting"
          batsman = {}
          batsman[:web_profile_id] = batsman_data["profile_url"]&.split("/")&.dig(-2)
          batsman[:runs_scored] = batsman_data["runs_scored"]
          batsman[:strike_rate] = batsman_data["strike_rate"]
          batsman[:sixes] = batsman_data["sixes"]
          batsman[:fours] = batsman_data["fours"]
          batsman[:balls_faced] = batsman_data["balls_faced"]
          batsmen_scorecard_data << batsman
        end
      end
    end
  end
end