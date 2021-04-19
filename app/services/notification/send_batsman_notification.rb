module Notification
  class SendBatsmanNotification
    attr_reader :match_key, :batsmen_scorecard_data, :batsmen_score_hash

    def initialize(match_key)
      @match_key = match_key
      @batsmen_scorecard_data = []
      @batsmen_score_hash = {}
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
          batsman[:name] = batsman_data["profile_url"]&.split("/")&.dig(-1)&.titleize
          batsmen_score_hash[batsman[:batsman_match_id]] = "#{batsman[:name]} R: #{batsman[:runs_scored] || 0}, B: #{batsman[:balls_faced] || 0}, 6s: #{batsman[:sixes] || 0}, 4s: #{batsman[:fours] || 0}, SR: #{batsman[:strike_rate] || 0.0}"
          batsmen_scorecard_data << batsman
        end
      end
    end

    def matured_notifications
      batsman_notifications = []
      batsmen_scorecard_data.each do |batsman|
        notifications = BatsmanScoreNotifier.where(batsman_match_id: batsman[:batsman_match_id])
        .where("balls_faced <= ? OR runs_scored <= ? OR sixes <= ? OR fours <= ?", batsman[:balls_faced], batsman[:runs_scored], batsman[:sixes], batsman[:fours])
        batsman_notifications += notifications
        notifications.destroy_all
      end
      # SendPushNotificationWorker.perform_async(batsman_notifications) unless batsman_notifications.blank?
      send_push_notifications(batsman_notifications) unless batsman_notifications.blank?
    end

    def send_push_notifications(batsman_notifications)
      batsman_notifications.group_by(&:user_id).each do |user_id, notifications|
        user = User.find_by(id: user_id)
        message = create_message(notifications.pluck(:batsman_match_id))
        # binding.pry
        web_push(message, user&.endpoint, user&.p256dh, user&.auth)
      end
      batsman_notifications.clear
    end

    def web_push(message, user_endpoint, user_p256dh, user_auth)
      Webpush.payload_send(
        message: message,
        endpoint: user_endpoint,
        p256dh: user_p256dh,
        auth: user_auth,
        vapid: {
          public_key: ENV['VAPID_PUBLIC_KEY'],
          private_key: ENV['VAPID_PRIVATE_KEY']
        }
      )
    end

    def create_message(batsman_match_ids)
      message = ""
      batsman_match_ids.map {|id| message += "#{batsmen_score_hash[id]}/n"}
      message
    end
  end
end