class RemoveUserColumnsFromScoreNotifier < ActiveRecord::Migration[6.0]
  def change
    remove_column :batsman_score_notifiers, :user_endpoint
    remove_column :batsman_score_notifiers, :user_p256dh
    remove_column :batsman_score_notifiers, :user_auth
  end
end
