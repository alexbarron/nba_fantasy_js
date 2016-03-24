class RosterSpotsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def create
    if !!current_user.team
      response = current_user.team.add_player(params[:player_id])
      redirect_to current_user.team, alert: response
    else
      redirect_to new_team_path, alert: "Please create a team first."
    end
  end

  def destroy
    #spot = RosterSpot.where("player_id = ? AND team_id = ?", params[:player_id], params[:team_id]).first
    team = Team.find(params[:team_id])
    team.drop_player(params[:player_id])
    redirect_to team, alert: "Player successfully dropped."
  end

  def update
    spot = RosterSpot.where("player_id = ? AND team_id = ?", params[:player_id], params[:team_id]).first
    response = spot.toggle
    redirect_to spot.team, alert: response
  end

end
