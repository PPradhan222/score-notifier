class ScoreboardChannel < ApplicationCable::Channel
  def subscribed
    match = Match.find_by(id: params[:match_id])
    stream_for match
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
