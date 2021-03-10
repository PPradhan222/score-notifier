class Team < ApplicationRecord
  has_many :team_squads, dependent: :destroy
  has_many :matches, through: :team_squads
  
  validates :web_team_id, :name, uniqueness: true
end
