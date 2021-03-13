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
    result = Spiders::InitializeScorecard.process(url, match)
    redirect_to matches_path
  end

  def update_scorecard
    url = "https://www.cricbuzz.com/live-cricket-scorecard/" + match.web_match_url
    Spiders::UpdateScorecard.process(url, match)
    redirect_to matches_path
  end

  private

  def load_match
    @match = Match.find_by(id: params[:id])
  end
end
