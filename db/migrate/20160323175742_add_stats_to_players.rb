class AddStatsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :points, :integer, default: 0
    add_column :players, :rebounds, :integer, default: 0
    add_column :players, :assists, :integer, default: 0
    add_column :players, :blocks, :integer, default: 0
    add_column :players, :steals, :integer, default: 0
    add_column :players, :games_played, :integer, default: 0
    add_column :players, :player_url, :string
  end
end
