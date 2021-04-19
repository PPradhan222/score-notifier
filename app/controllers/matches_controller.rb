class MatchesController < ApplicationController
  before_action :load_match, only: [:show, :live_score, :initialize_scorecard, :create_notifications,:update_scorecard, :add_notifications]
  before_action :load_user, only: :create_notifications
  attr_reader :match, :user

  def index
    @matches = Match.all
  end

  def show
    match_key = "match_#{match.web_match_id}"
    if (match.live? && $redis.exists?(match_key))
      redirect_to live_score_match_path(match)
      return
    end
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
    return unless user
    batsmen = params[:batsmen].permit!
    match_id = match.id
    batsmen.to_hash.each do |batsman_data|
      next if (batsman_data[1]["runs_scored"] + batsman_data[1]["balls_faced"] + batsman_data[1]["fours"] + batsman_data[1]["sixes"] + batsman_data[1]["strike_rate"]).blank?
      batsman_match_id = "match_#{match.web_match_id}_#{batsman_data[0].split("/").third}"
      batSN = user.batsman_score_notifiers
      .create(match_id: match_id, batsman_match_id: batsman_match_id, runs_scored: batsman_data[1]["runs_scored"], balls_faced: batsman_data[1]["balls_faced"], fours: batsman_data[1]["fours"], sixes: batsman_data[1]["sixes"], strike_rate: batsman_data[1]["strike_rate"])
    end
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

  def load_user
    @user = User.find_by(endpoint: params[:user_endpoint])
    @user = User.create(endpoint: params[:user_endpoint], p256dh: params[:user_p256dh], auth: params[:user_auth]) unless @user
  end
end
