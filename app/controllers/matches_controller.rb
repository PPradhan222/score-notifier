class MatchesController < ApplicationController
  before_action :load_match, only: [:show, :live_score, :initialize_scorecard, :create_notifications,:update_scorecard, :add_notifications]
  attr_reader :match

  def index
    @matches = Match.all
  end

  def show
    @innings = @match.innings
  end

  def add_notifications
    match_key = "match_#{match.web_match_id}"
    unless $redis.exists? match_key
      redirect_to match
      return
    end
    @match_data = JSON.parse($redis.get match_key)
  end

  def create_notifications
    # binding.pry
  end

  def live_score
    match_key = "match_#{match.web_match_id}"
    unless $redis.exists? match_key
      redirect_to match
      return
    end
    @match_data = JSON.parse($redis.get match_key)
  end

  def initialize_scorecard
    url = "https://www.cricbuzz.com/cricket-match-facts/" + match.web_match_url
    InitializeScorecardWorker.perform_async(url, match.id)
    redirect_to match ? match : matches_path
  end

  def update_scorecard
    url = "https://www.cricbuzz.com/live-cricket-scorecard/" + match.web_match_url
    UpdateScorecardWorker.perform_async(url, match.id)
    redirect_to match ? match : matches_path
  end

  def update_status
    url = "https://www.cricbuzz.com/cricket-match/live-scores/recent-matches"
    UpdateMatchStatusWorker.perform_async(url)
    redirect_to matches_path
  end

  private

  def load_match
    @match = Match.find_by(id: params[:id])
  end
end
