module WebScrapper
  class UpdateMatchesStatus
    attr_reader :recent_matches

    def initialize(recent_matches)
      @recent_matches = recent_matches
    end

    def call
      update_to_recent
      update_to_live
    end

    private

    def update_to_recent
      Match.not_recent.each do |match|
        if recent_matches.keys.include? match.web_match_id
          match.recent!
          match.update(result: recent_matches[match.web_match_id])
        end
      end
    end

    def update_to_live
      Match.upcoming.each do |match|
        match.live! if match.date_time.before?(Time.now)
      end
    end
  end
end