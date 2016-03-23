class Team < ActiveRecord::Base
  validates_presence_of :name, :user_id
  belongs_to :user

  def owner_name
    self.user.name
  end

  def salary
    70000000 - self.salary_remaining
  end
end
