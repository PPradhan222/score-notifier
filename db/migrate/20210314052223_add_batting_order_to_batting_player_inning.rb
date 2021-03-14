class AddBattingOrderToBattingPlayerInning < ActiveRecord::Migration[6.0]
  def change
    add_column :batting_player_innings, :batting_order, :integer, default: 12
  end
end
