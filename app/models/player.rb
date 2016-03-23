require 'open-uri'

class Player < ActiveRecord::Base
  has_many :roster_spots
  has_many :teams, through: :roster_spots
  validates :position, inclusion: { in: %w(PG SG SF PF C)}
  validates_presence_of :name, :position

  def calculate_score
    self.score = points + (2 * (rebounds + assists + blocks + steals))
    self.save
  end

  def update_stats
    stats_hash = self.get_player_stats
    stats_hash[:salary] = self.get_player_salary
    self.update(stats_hash)
    self.calculate_score
  end

  def value
    self.score / (self.salary.to_f / 1000000)
  end

  def self.most_valuable
    Player.all.max_by do |player|
      player.value
    end
  end

  def self.least_valuable
    Player.all.min_by do |player|
      player.value
    end
  end

  def get_player_stats
    url = self.player_url
    page = Nokogiri::HTML(open(url))
    season = page.css("table#totals tr.full_table").last
    stats_array = array_maker(season)
    stats_hash = {
      points: stats_array[30], 
      assists: stats_array[25], 
      rebounds: stats_array[24], 
      blocks: stats_array[27], 
      steals: stats_array[26], 
      games_played: stats_array[6], 
    }
    return stats_hash
  end

  def get_player_salary
    url = self.player_url
    page = Nokogiri::HTML(open(url))
    contract = page.css("table#contract tr").last
    contract_array = array_maker(contract)
    salary = contract_array[2]
    salary.delete("$ ,").to_i
  end

  def array_maker(element)
    element.text.split("\n").map {|x| x.strip}
  end

  # How to construct (consider 2 different methods)
  # Need to scrape new stats off player_url and save to hash
  # Save old player score
  # Update/calculate player's current score based on updated stats
  # Calculate difference between new score and old score
  # Loop through all their roster_spots
  # Add difference to all teams where player is a starter
  # Add difference/2 to all teams where player is benched
  def update_teams_score
    #need scraper to compare stats, save new_player_stats_hash
    old_score = self.score
    self.update(new_player_stats_hash)
    self.calculate_score
    difference = self.score - old_score
    player.roster_spots.each do |roster_spot|
      if roster_spot.starter
        roster_spot.team.score += difference
      else
        roster_spot.team.score += (difference / 2)
      end
      roster_spot.team.save
    end
  end

end
