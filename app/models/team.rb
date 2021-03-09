class Team < ApplicationRecord
  has_many :match_teams, dependent: :destroy
  has_many :matches, through: :match_teams
end
