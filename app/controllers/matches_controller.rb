class MatchesController < ApplicationController
  before_action :load_match, only: [:show, :initialize_scorecard, :update_scorecard]
  attr_reader :match

  def index
    @matches = Match.all
  end

  def show
    @innings = @match.innings
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
