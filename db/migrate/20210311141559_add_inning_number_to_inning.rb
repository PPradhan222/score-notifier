class AddInningNumberToInning < ActiveRecord::Migration[6.0]
  def change
    add_column :innings, :inning_number, :integer
  end
end
