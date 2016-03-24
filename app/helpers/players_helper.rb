module PlayersHelper

  def add_player_column(player)
    if current_user.team.players.include?(player)
      "This player is on your team"
    else
      link_to "Add Player", roster_spots_path(player_id: player.id), method: :post, class: "btn btn-success btn-xs"
    end
  end

  def has_team_check
    if !!current_user && !!current_user.team
      render 'players/has_team_options'
    end
  end

  def admin_options
    if admin_check?
      render 'players/admin_player_options'
    end
  end
end