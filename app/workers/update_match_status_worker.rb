class UpdateMatchStatusWorker
  include Sidekiq::Worker

  def perform(url)
    Spiders::RecentMatchesSpider.process(url)
  end
end
