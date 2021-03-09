class Team < ApplicationRecord
  has_many :match_teams, dependent: :destroy
  has_many :matches, through: :match_teams
  
  validates :web_team_id, :name, uniqueness: true
end
