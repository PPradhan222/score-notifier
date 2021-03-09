class Match < ApplicationRecord
  has_many :innings, dependent: :destroy
  # max 2 innings for odi & t20, max 4 innings for test
  has_many :match_teams, dependent: :destroy
  # exactly 2 match_teams & teams
  has_many :teams, through: :match_teams
end
