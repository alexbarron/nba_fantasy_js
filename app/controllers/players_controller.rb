class PlayersController < ApplicationController
  load_and_authorize_resource
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :update_all]

  def index
    if params[:affordable] && @user = User.find(params[:user_id])
      @players = Player.where("salary < ?", @user.team.salary_remaining).sort {|a,b| b.score<=>a.score} - @user.team.players
    elsif params[:available] && @user = User.find(params[:user_id])
      @players = Player.all.sort {|a,b| b.score<=>a.score} - @user.team.players
    else
      @players = Player.all.sort {|a,b| b.score<=>a.score}
    end

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @players}
    end
  end

  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @player}
    end
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.find_or_create_by(player_params)
    if @player.save
      redirect_to @player
    else
      flash[:alert] = @player.errors.full_messages.first
      render :new
    end
  end

  def edit

  end

  def update
    @player.update(player_params)
    redirect_to @player
  end

  def destroy
    @player.destroy
    redirect_to players_path
  end

  def update_all
    if current_user.admin?
      Player.update_all_players
      redirect_to players_path, notice: "Successfully updated all players."
    else
      redirect_to players_path, alert: "You're not allowed to do that."
    end
  end

  private

  def player_params
    params.require(:player).permit(:player_url)
  end

  def set_player
    @player = Player.find(params[:id])
  end
end
