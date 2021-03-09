class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.string :name
      t.string :series_name
      t.string :format
      t.string :level
      t.string :venue
      t.datetime :date_time
      t.string :status
      t.string :web_match_id
      t.string :result
      t.string :toss

      t.timestamps
    end
  end
end
