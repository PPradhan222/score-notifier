class User < ApplicationRecord
  has_many :batsman_score_notifiers, dependent: :destroy
end
