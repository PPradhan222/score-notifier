class CreateBalls < ActiveRecord::Migration[6.0]
  def change
    create_table :balls do |t|
      t.integer :ball_number
      t.integer :over_number
      t.string :ball_type
      t.integer :run
      t.string :run_type
      t.boolean :wicket
      t.string :wicket_type
      t.references :inning, null: false, foreign_key: true

      t.timestamps
    end
  end
end
