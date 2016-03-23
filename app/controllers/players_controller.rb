class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @players = Player.all.sort {|a,b| b.score<=>a.score}
  end

  def show

  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    @player.save
    redirect_to @player
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

  def most_valuable
    @players = Player.most_valuable_players
  end

  private

  def player_params
    params.require(:player).permit(:name, :salary, :position)
  end

  def set_player
    @player = Player.find(params[:id])
  end
end
