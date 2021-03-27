class TeamDataWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(url)
    Spiders::TeamDataSpider.process(url)
  end
end
