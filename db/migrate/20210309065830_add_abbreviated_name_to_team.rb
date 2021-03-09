class AddAbbreviatedNameToTeam < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :abbreviated_name, :string
  end
end
