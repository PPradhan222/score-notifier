class NotificationWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'notification'

  def perform(web_match_id)
    Notification::SendNotification.new(web_match_id).call
  end
end
