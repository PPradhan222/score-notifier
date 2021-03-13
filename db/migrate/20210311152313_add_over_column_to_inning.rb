class AddOverColumnToInning < ActiveRecord::Migration[6.0]
  def change
    add_column :innings, :overs, :decimal
  end
end
