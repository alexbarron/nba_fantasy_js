class PlayersWorker

  include Sidekiq::Worker

  def perform
    Player.update_all_players
  end
end