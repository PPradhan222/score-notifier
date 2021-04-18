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
      matured_notifications
    end

    private

    def batsmen_scorecard
      match_data = JSON.parse $redis.get match_key
      match_data["innings"].each do |inning_data|
        inning_data["batting_card"].each do |batsman_data|
          # next unless batsman_data["wicket_status"] == "batting"
          batsman = {}
          batsman[:batsman_match_id] = match_key + "_" + batsman_data["profile_url"]&.split("/")&.dig(-2)
          batsman[:runs_scored] = batsman_data["runs_scored"]
          batsman[:strike_rate] = batsman_data["strike_rate"]
          batsman[:sixes] = batsman_data["sixes"]
          batsman[:fours] = batsman_data["fours"]
          batsman[:balls_faced] = batsman_data["balls_faced"]
          batsmen_scorecard_data << batsman
        end
      end
    end

    def matured_notifications
      batsman_notifications = []
      batsmen_scorecard_data.each do |batsman|
        batsman_notifications += BatsmanScoreNotifier.where(batsman_match_id: batsman[:batsman_match_id])
        .where("balls_faced <= ? OR runs_scored <= ? OR sixes <= ? OR fours <= ?", batsman[:balls_faced], batsman[:runs_scored], batsman[:sixes], batsman[:fours])
      end
      SendPushNotificationWorker.perform_async(batsman_notifications) unless batsman_notifications.blank?
    end
  end
end