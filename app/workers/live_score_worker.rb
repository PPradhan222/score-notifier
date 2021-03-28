class LiveScoreWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: "critical"

  def perform(*args)
    live_matches = Match.live.last(5)
    live_matches.each do |live_match|
      url = "https://www.cricbuzz.com/live-cricket-scorecard/" + live_match.web_match_url
      unless live_match.toss
        InitializeScorecardWorker.perform_async(url, live_match.id)
        sleep 2
      end
      UpdateScorecardWorker.perform_async(url, live_match.id)
      sleep 3
    end
  end
end
