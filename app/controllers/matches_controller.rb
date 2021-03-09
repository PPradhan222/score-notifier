class MatchesController < ApplicationController
  def index
    @matches = Match.where(status: 'upcoming')
  end
end
