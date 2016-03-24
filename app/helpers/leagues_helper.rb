module LeaguesHelper

  def join_leave_helper(league)
    if has_team_check?
      if league == current_user.team.league
        link_to "Leave League", leave_league_path(id: current_user.team), method: :post, class: "btn btn-danger btn-sm", data: {confirm: "Are you sure?"}
      elsif !!current_user.team.league
        link_to "Join League", join_league_path(id: current_user.team, league_id: @league.id), method: :post, class: "btn btn-success btn-sm", data: {confirm: "Are you sure? This will remove your team from your current league."}
      else
        link_to "Join League", join_league_path(id: current_user.team, league_id: @league.id), method: :post, class: "btn btn-success btn-sm"
      end
    else
      link_to "Create Team In This League", new_league_team_path(league)
    end
  end
end