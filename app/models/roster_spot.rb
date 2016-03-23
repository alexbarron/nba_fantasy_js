class RosterSpot < ActiveRecord::Base
  belongs_to :team
  belongs_to :player

  def toggle
    if self.starter
      self.starter = false
      self.save
      return "Benched #{self.player.name}"
    else
      if self.team.starters.count >= 5
        return "You already have 5 starters, bench a player before adding another starter."
      else
        self.starter = true
        self.save
        return "Starting #{self.player.name}"
      end
    end  
  end
end
