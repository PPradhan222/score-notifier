class TeamSquadMember < ApplicationRecord
  belongs_to :player
  belongs_to :team_squad
  has_many :player_runs_notifiers
  validates :player_id, uniqueness: { scope: :team_squad_id }
end
