class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :level
      t.string :web_team_id

      t.timestamps
    end
  end
end
