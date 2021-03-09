class Match < ApplicationRecord
  has_many :innings
  # max 2 innings for odi & t20, max 4 innings for test
  has_many :match_teams
  # exactly 2 match_teams & teams
  has_many :teams, through: :match_teams
end
