module WebScrapper
  class UpdateMatchesStatus
    attr_reader :recent_match_ids

    def initialize(match_ids)
      @recent_match_ids = match_ids
    end

    def call
      update_to_recent
      update_to_live
    end

    private

    def update_to_recent
      Match.not_recent.each do |match|
        match.recent! if recent_match_ids.include? match.web_match_id
      end
    end

    def update_to_live
      Match.upcoming.each do |match|
        match.live! if match.date_time.before?(Time.now)
      end
    end
  end
end