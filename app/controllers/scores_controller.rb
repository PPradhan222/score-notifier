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
end
