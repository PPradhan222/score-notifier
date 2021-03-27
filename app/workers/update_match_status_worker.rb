class UpdateMatchStatusWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(url)
    Spiders::RecentMatchesSpider.process(url)
  end
end
