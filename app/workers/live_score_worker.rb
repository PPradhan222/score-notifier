class LiveScoreWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: "critical"

  def perform(*args)
    live_matches = Match.live.last(5)
    live_matches.each do |live_match|
      scorecard_url = "https://www.cricbuzz.com/live-cricket-scorecard/" + live_match.web_match_url
      match_facts_url = "https://www.cricbuzz.com/cricket-match-facts/" + live_match.web_match_url
      unless live_match.toss
        InitializeScorecardWorker.perform_async(match_facts_url, live_match.id)
        sleep 2
      end
      UpdateScorecardWorker.perform_async(scorecard_url, live_match.id)
      sleep 3
    end
  end
end
