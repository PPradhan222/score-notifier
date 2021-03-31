module Notification
  class SendPlayerRunsNotification
    attr_reader :batsmen_runs

    def initialize(batsmen_runs_data)
      @batsmen_runs = batsmen_runs_data
    end

    def call
      run_notifications = []
      batsmen_runs.each do |batsman|
        run_notifications += TeamSquadMember.find_by(player_profile_id: batsman[0]).player_runs_notifiers.where("runs <= ?", batsman[1])
      end
      run_notifications.map { |rn| rn.destroy }
    end
  end
end