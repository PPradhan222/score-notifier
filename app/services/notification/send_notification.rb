module Notification
  class SendNotification
    attr_reader :match_key
    
    def initialize(web_match_id)
      @match_key = "match_#{web_match_id}"
    end

    def call
      return unless $redis.exists? match_key
      Notification::SendBatsmanNotification.new(match_key).call
    end
  end
end