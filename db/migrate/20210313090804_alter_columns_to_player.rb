class AlterColumnsToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :web_profile_url, :string
  end
end
