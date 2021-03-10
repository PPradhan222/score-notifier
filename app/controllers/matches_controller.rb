class MatchesController < ApplicationController
  def index
    @matches = Match.where(status: 'upcoming')
  end

  def show
    @match = Match.find_by(id: params[:id])
  end
end
