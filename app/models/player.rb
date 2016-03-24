require 'open-uri'

class Player < ActiveRecord::Base
  has_many :roster_spots, dependent: :destroy
  has_many :teams, through: :roster_spots

  def calculate_score
    self.score = points + (2 * (rebounds + assists + blocks + steals))
    self.save
  end

  def calculate_new_score(hash)
    hash[:points].to_i + (2 * (hash[:rebounds].to_i + hash[:assists].to_i + hash[:blocks].to_i + hash[:steals].to_i))
  end

  def self.update_all_players
    Player.all.each {|player| player.update_info}
  end

  def update_info
    old_score = self.score
    info_hash = self.get_player_info
    info_hash[:score] = self.calculate_new_score(info_hash)
    if old_score != info_hash[:score]
      self.update(info_hash)
      self.update_teams_score(old_score, self.score)
    end
  end

  def value
    (self.score / (self.salary.to_f / 1000000)).round(2)
  end

  def status(team)
    spot = self.roster_spots.where(team_id: team.id).first
    spot.starter ? "Starter" : "Benched"
  end

  def set_status(team, lineup_status)
    spot = self.roster_spots.where(team_id: team.id).first
    spot.starter = lineup_status
    spot.save
  end

  def self.most_valuable_players
    Player.all.max_by(10) do |player|
      player.value
    end
  end

  def self.most_popular_players
    Player.all.max_by(10) do |player|
      player.teams.count
    end
  end

  def self.highest_scoring_players
    Player.all.max_by(10) do |player|
      player.score
    end
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

  def get_player_info
    url = self.player_url
    page = Nokogiri::HTML(open(url))

    name = page.css("h1").first.text
    
    salary = get_salary(page)

    season = page.css("table#totals tr.full_table").last
    stats_array = array_maker(season)
    info_hash = {
      points: stats_array[30].to_i, 
      assists: stats_array[25].to_i, 
      rebounds: stats_array[24].to_i, 
      blocks: stats_array[27].to_i, 
      steals: stats_array[26].to_i, 
      games_played: stats_array[6].to_i, 
      position: stats_array[5],
      salary: salary.to_i,
      name: name
    }
    return info_hash
  end

  def get_salary(page)
    contract = page.css("table#contract tr").last
    contract_array = array_maker(contract)
    salary = contract_array[2]
    salary.delete("$ ,").to_i
  end

  def array_maker(element)
    element.text.split("\n").map {|x| x.strip}
  end

  def update_teams_score(old_score, new_score)
    difference = new_score - old_score
    score = 0
    self.roster_spots.each do |roster_spot|
      if roster_spot.starter
        score = roster_spot.team.score + difference
      else
        score = roster_spot.team.score + (difference / 2)
      end
      roster_spot.team.update(score: score)
    end
  end

end
