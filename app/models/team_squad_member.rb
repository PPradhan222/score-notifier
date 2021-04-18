class TeamSquadMember < ApplicationRecord
  belongs_to :player
  belongs_to :team_squad
  validates :player_id, uniqueness: { scope: :team_squad_id }
end
