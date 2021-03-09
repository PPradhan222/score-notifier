class Inning < ApplicationRecord
  belongs_to :match
  has_many :batting_player_innings, dependent: :destroy
  has_many :bowling_player_innings, dependent: :destroy
  has_many :batsmen, through: :batting_player_innings, source: :player
  has_many :bowlers, through: :bowling_player_innings, source: :player
  has_many :balls, dependent: :destroy

  delegate :teams, to: :match
end
