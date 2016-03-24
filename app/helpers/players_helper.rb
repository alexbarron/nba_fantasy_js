module PlayersHelper

  def add_player_column(player)
    if current_user.team.players.include?(player)
      "This player is on your team"
    else
      link_to "Add Player", roster_spots_path(player_id: player.id), method: :post, class: "btn btn-success btn-xs"
    end
  end

  def has_team_options
    if has_team_check?
      render 'players/has_team_options'
    end
  end

  def admin_options
    if admin_check?
      render 'players/admin_player_options'
    end
  end

  def display_salary_remaining
    if has_team_check?
      content_tag :h4, "You have #{number_to_currency(current_user.team.salary_remaining, precision: 0)} to add players."
    end
  end

end