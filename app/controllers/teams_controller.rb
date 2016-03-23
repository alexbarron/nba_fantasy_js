class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @teams = Team.all.sort {|a,b| b.score<=>a.score}
  end

  def show

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

  private

  def team_params
    params.require(:team).permit(:name, :user_id)
  end

  def set_team
    @team = Team.find(params[:id])
  end
end
