class ScoresController < ApplicationController
  def index
  end

  def show
  end

  def scrape
    url = "https://www.cricbuzz.com/cricket-match/live-scores/recent-matches"
    result = Spiders::CricketSpider.process(url)
    # result = Spiders::CricketSpider.parse!(:parse, url: url)
    redirect_to scores_path
  end

  def scrape_team_data
    url = "https://www.cricbuzz.com/cricket-team"
    result = Spiders::TeamDataSpider.process(url)
    redirect_to teams_path
  end

  def scrape_upcoming_matches
    url = "https://www.cricbuzz.com/cricket-schedule/upcoming-series/international"
    result = Spiders::UpcomingMatchesSpider.process(url)

    redirect_to matches_path
  end

  def scrape_team_squad_members
    @matches = Match.all
    WebScrapper::ScrapeUpcomingMatchesTeamSquad.new(@matches).call

    redirect_to matches_path
  end
end
