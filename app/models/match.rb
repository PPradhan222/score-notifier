class Match < ApplicationRecord
  has_many :innings, dependent: :destroy
  # max 2 innings for odi & t20, max 4 innings for test
  has_many :team_squads, dependent: :destroy
  # exactly 2 team_squads & teams
  has_many :teams, through: :team_squads

  validates :web_match_url, uniqueness: true
end
