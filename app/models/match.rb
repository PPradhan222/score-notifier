class Match < ApplicationRecord
  has_many :innings, dependent: :destroy
  # max 2 innings for odi & t20, max 4 innings for test
  has_many :team_squads, dependent: :destroy
  # exactly 2 team_squads & teams
  has_many :teams, through: :team_squads
  has_many :squad_members, through: :team_squads, source: :team_squad_members

  validates :web_match_id, uniqueness: true
end
