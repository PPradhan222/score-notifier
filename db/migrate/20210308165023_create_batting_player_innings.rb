class CreateBattingPlayerInnings < ActiveRecord::Migration[6.0]
  def change
    create_table :batting_player_innings do |t|
      t.integer :runs_scored
      t.integer :balls_faced
      t.integer :fours
      t.integer :sixes
      t.decimal :strike_rate
      t.string :wicket_status
      t.references :inning, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
