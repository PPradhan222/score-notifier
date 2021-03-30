class User < ApplicationRecord
  has_many :player_runs_notifier, dependent: :destroy
end
