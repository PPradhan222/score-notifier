class CreateBowlingPlayerInnings < ActiveRecord::Migration[6.0]
  def change
    create_table :bowling_player_innings do |t|
      t.integer :runs_conceded
      t.integer :balls_bowled
      t.integer :wickets_taken
      t.integer :maiden_overs
      t.decimal :economy_rate
      t.decimal :overs
      t.references :inning, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
