class Player < ApplicationRecord
  has_many :batting_player_innings
  has_many :bowling_player_innings
  has_many :batting_innings, through: :batting_player_innings, source: :inning
  has_many :bowling_innings, through: :bowling_player_innings, source: :inning
end
