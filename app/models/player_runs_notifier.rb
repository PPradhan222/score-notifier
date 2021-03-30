class PlayerRunsNotifier < ApplicationRecord
  belongs_to :user
  belongs_to :team_squad_member

  validates :runs, numericality: { less_than_or_equal_to: 500, only_integer: true }
  validate :runs_only_in_tens_format, :more_than_or_equal_to_zero

  def runs_only_in_tens_format
    errors.add(:runs_format, 'should be in tens') unless runs % 10 == 0
  end

  def more_than_or_equal_to_zero
    errors.add(:minimum_runs, 'should be more than or equal to zero') unless runs >= 0
  end
end
