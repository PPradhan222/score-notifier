class UpdateScorecardWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(url, match_id)
    match = Match.find_by(id: match_id)
   Spiders::UpdateScorecardSpider.process(url, match)
  end
end
