class UpcomingMatchesWorker
  include Sidekiq::Worker

  def perform(url)
    Spiders::UpcomingMatchesSpider.process(url)
  end
end
