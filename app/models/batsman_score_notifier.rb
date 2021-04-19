class BatsmanScoreNotifier < ApplicationRecord
  belongs_to :user
  belongs_to :match

  validates :runs_scored, numericality: { less_than_or_equal_to: 500, only_integer: true }
  # validate :more_than_zero

  # def runs_only_in_tens_format
  #   errors.add(:runs_format, 'should be in tens') unless runs % 10 == 0
  # end

  # def more_than_zero
  #   if(runs_scored <= 0 || balls_faced <= 0 || fours <= 0 || sixes <= 0 || strike_rate <= 0)
  #      errors.add(:minimum_value, 'should be more than zero')
  #   end
  # end
end
