class UpcomingMatchesWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(urls)
    urls.map { |url| Spiders::UpcomingMatchesSpider.process(url) }
  end
end
