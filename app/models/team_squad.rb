class TeamSquad < ApplicationRecord
  belongs_to :match
  belongs_to :team
  has_many :team_squad_members, dependent: :destroy
  has_many :players, through: :team_squad_members
end
