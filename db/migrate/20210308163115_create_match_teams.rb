class CreateMatchTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :match_teams do |t|
      t.references :match, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.string :score

      t.timestamps
    end
  end
end
