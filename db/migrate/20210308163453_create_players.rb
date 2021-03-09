class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :role
      t.string :web_profile_id

      t.timestamps
    end
  end
end
