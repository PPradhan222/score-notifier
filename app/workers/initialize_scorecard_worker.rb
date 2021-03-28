class InitializeScorecardWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'critical'

  def perform(url, match_id)
    match = Match.find_by(id: match_id)
    Spiders::InitializeScorecardSpider.process(url, match)
  end
end
