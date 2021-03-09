class Team < ApplicationRecord
  has_many :match_teams
  has_many :matches, through: :match_teams
end
