class TeamDataWorker
  include Sidekiq::Worker

  def perform(url)
    Spiders::TeamDataSpider.process(url)
  end
end
