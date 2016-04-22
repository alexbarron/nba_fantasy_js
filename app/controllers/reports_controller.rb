class ReportsController < ApplicationController
  def index
  end
  
  def most_valuable
    @players = Player.most_valuable_players
  end

  def most_popular_players
    @players = Player.most_popular_players
  end

  def most_efficient
    @teams = Team.most_efficient_teams
  end

  def most_popular_leagues
    @leagues = League.most_popular_leagues
  end

  def highest_scoring_players
    @players = Player.highest_scoring_players
  end
end