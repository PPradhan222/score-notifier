class TeamSquadMemberWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    matches = Match.all
    WebScrapper::ScrapeUpcomingMatchesTeamSquad.new(matches).call
  end
end
