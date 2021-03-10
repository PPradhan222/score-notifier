class TeamSquadMember < ApplicationRecord
  belongs_to :player
  belongs_to :team_squad
end
