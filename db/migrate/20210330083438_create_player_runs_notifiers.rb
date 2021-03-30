class CreatePlayerRunsNotifiers < ActiveRecord::Migration[6.0]
  def change
    create_table :player_runs_notifiers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :team_squad_member, null: false, foreign_key: true
      t.integer :runs

      t.timestamps
    end
  end
end
