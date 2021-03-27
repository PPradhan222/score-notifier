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
    TeamDataWorker.perform_async(url)
    redirect_to teams_path
  end

  def scrape_upcoming_matches
    url = "https://www.cricbuzz.com/cricket-schedule/upcoming-series/international"
    UpcomingMatchesWorker.perform_async(url)
    redirect_to matches_path
  end

# this method takes a lot of time to perform
  def scrape_team_squad_members
    TeamSquadMemberWorker.perform_async
    redirect_to matches_path
  end
end
