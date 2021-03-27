class UpcomingMatchesWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(url)
    Spiders::UpcomingMatchesSpider.process(url)
  end
end
