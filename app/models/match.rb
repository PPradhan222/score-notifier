class Match < ApplicationRecord
  has_many :innings, dependent: :destroy
  # max 2 innings for odi & t20, max 4 innings for test
  has_many :team_squads, dependent: :destroy
  # exactly 2 team_squads & teams
  has_many :teams, through: :team_squads
  has_many :squad_members, through: :team_squads, source: :team_squad_members

  validates :web_match_id, uniqueness: true

  enum status: [:recent, :live, :upcoming]
  scope :test, ->{ where(format: 'test') }
  scope :t20, ->{ where(format: 't20') }
  scope :odi, ->{ where(format: 'odi') }

  def test?
    format == 'test'
  end

  def day
    return 0 unless test?
    desc = name.split(",").last.strip.downcase
    return desc.include?("day") ? desc.split(" ").last.to_i : 0
  end
end
