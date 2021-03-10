class Player < ApplicationRecord
  has_many :batting_player_innings, dependent: :destroy
  has_many :bowling_player_innings, dependent: :destroy
  has_many :batting_innings, through: :batting_player_innings, source: :inning
  has_many :bowling_innings, through: :bowling_player_innings, source: :inning
  has_many :team_squad_members, dependent: :destroy

  validates :web_profile_id, uniqueness: true
end
