class Team < ActiveRecord::Base
  validates_presence_of :name, :user_id
  belongs_to :user
  has_many :roster_spots, dependent: :destroy
  has_many :players, through: :roster_spots

  def owner_name
    self.user.name
  end

  def salary
    70000000 - self.salary_remaining
  end

  def efficiency
    (self.score / (self.salary.to_f / 1000000)).round(2) unless self.salary == 0
  end

  def starters
    self.players.select do |player|
      player if player.status(self) == "Starter"
    end
  end

  def benchwarmers
    self.players.select do |player|
      player if player.status(self) == "Benched"
    end
  end

  def status_sorted_roster
    self.starters + self.benchwarmers
  end

  def add_player(player_id)
    player = Player.find(player_id)
    if player.salary < self.salary_remaining
      RosterSpot.create(player_id: player_id, team_id: self.id)
      self.salary_remaining -= player.salary
      self.save
      return "#{player.name} added to #{self.name}"
    else
      return "Sorry, you can't afford that player. Try dropping players to free up salary."
    end
  end

  def drop_player(spot)
    self.salary_remaining += spot.player.salary
    self.save
    spot.destroy
  end

end
