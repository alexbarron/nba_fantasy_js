class Player < ActiveRecord::Base
  validates :position, inclusion: { in: %w(PG SG SF PF C)}
  validates_presence_of :name, :position
end
