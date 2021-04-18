class SendPushNotificationWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'notification'

  def perform(notifications)
    # notifications.group_by(&:user_id)
  end
end
