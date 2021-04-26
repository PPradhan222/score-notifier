class AddColumnToMatch < ActiveRecord::Migration[6.0]
  def change
    add_column :matches, :team1_name, :string
    add_column :matches, :team2_name, :string
  end
end
