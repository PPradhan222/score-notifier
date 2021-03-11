class ChangeStatusColumnOfMatch < ActiveRecord::Migration[6.0]
  def change
    remove_column :matches, :status, :string
    add_column :matches, :status, :integer
  end
end
