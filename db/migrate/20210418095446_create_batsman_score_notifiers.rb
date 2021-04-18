class CreateBatsmanScoreNotifiers < ActiveRecord::Migration[6.0]
  def change
    create_table :batsman_score_notifiers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :batsman_match_id, null: false
      t.references :match, null: false, foreign_key: true
      t.string :user_endpoint, null: false
      t.string :user_p256dh, null: false
      t.string :user_auth, null: false
      t.integer :runs_scored
      t.integer :balls_faced
      t.integer :fours
      t.integer :sixes
      t.decimal :strike_rate

      t.timestamps
    end
  end
end
