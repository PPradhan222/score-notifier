class InitializeScorecardWorker
  include Sidekiq::Worker
  sidekiq_options retry: 2

  def perform(url, match_id)
    match = Match.find_by(id: match_id)
    Spiders::InitializeScorecardSpider.process(url, match)
  end
end
