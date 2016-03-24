class TeamsController < ApplicationController
  load_and_authorize_resource
  before_action :set_team, only: [:show, :edit, :update, :destroy, :join_league]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :join_league]

  def index
    @teams = Team.all.sort {|a,b| b.score<=>a.score}
  end

  def show
    @players = @team.status_sorted_roster
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.user = current_user
    @team.save
    redirect_to @team
  end

  def edit

  end

  def update
    @team.update(team_params)
    redirect_to @team
  end

  def destroy
    @team.destroy
    redirect_to teams_path
  end

  def most_efficient
    @teams = Team.most_efficient_teams
  end

  def join_league
    @team.league_id = params[:league_id]
    @team.save
    redirect_to @team.league, alert: "You've joined #{@team.league.name}."
  end

  def leave_league
    @team.league_id = nil
    @team.save
    redirect_to @team, alert: "You've left the league."
  end

  private

  def team_params
    params.require(:team).permit(:name, :user_id)
  end

  def set_team
    @team = Team.find(params[:id])
  end
end
