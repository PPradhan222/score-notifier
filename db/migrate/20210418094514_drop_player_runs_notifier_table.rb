class DropPlayerRunsNotifierTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :player_runs_notifiers
  end
end
