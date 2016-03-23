class Player < ActiveRecord::Base
  has_many :roster_spots
  has_many :teams, through: :roster_spots
  validates :position, inclusion: { in: %w(PG SG SF PF C)}
  validates_presence_of :name, :position
end
