class TeamsController < ApplicationController
  load_and_authorize_resource
  before_action :set_team, only: [:show, :edit, :update, :destroy, :join_league]
  before_action :check_user_has_team, only: [:new, :create]

  def index
    if params[:league_id]
      @league = League.find(params[:league_id])
      @teams = @league.teams.order(score: :desc)
    else
      @teams = Team.order(score: :desc)
    end
  end

  def show
    if params[:league_id]
      @team = League.find(params[:league_id]).teams.find(params[:id])
    end
    @players = @team.status_sorted_roster
    @spots = @players.collect {|player| player.roster_spots.where(team_id: @team.id).first}

    respond_to do |format|
      format.html { render :show }
      format.json { render json: @team}
    end
  end

  def new
    if params[:league_id] && @league = League.find(params[:league_id])
      @team = @league.teams.build
    else
      @team = Team.new
    end
  end

  def create
    @team = current_user.build_team(team_params)
    if @team.save
      redirect_to @team , notice: @team.team_setup
    else
      flash.now[:alert] = @team.errors.full_messages.first
      render :new
    end
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

  def join_league
    @team.league_id = params[:league_id]
    @team.save
    redirect_to @team.league, notice: "You've joined #{@team.league.name}."
  end

  def leave_league
    @team.league_id = nil
    @team.save
    redirect_to @team, notice: "You've left the league."
  end

  private

  def team_params
    params.require(:team).permit(:name, :user_id, :league_id, player_ids: [], players_attributes: [:player_url])
  end

  def set_team
    @team = Team.find(params[:id])
  end

  def check_user_has_team
    if !!current_user.team
      redirect_to current_user.team, alert: "You must delete this team before creating another."
    end
  end
end
