class League < ActiveRecord::Base
  has_many :teams
  belongs_to :user

  def commissioner_name
    self.user.name
  end
end
