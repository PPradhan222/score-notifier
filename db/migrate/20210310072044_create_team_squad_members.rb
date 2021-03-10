class CreateTeamSquadMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :team_squad_members do |t|
      t.string :status
      t.references :player, null: false, foreign_key: true
      t.references :team_squad, null: false, foreign_key: true

      t.timestamps
    end
  end
end
