class Ability
  include CanCan::Ability

  def initialize(user)

    user.can :read, Player
    user.can :read, Team
    user.can :read, RosterSpot
    user.can :read, User

    user.can :manage, Team, {user_id: user.id}
    user.can :manage, RosterSpot, {team_id: user.team.id}
    return if user.user?

    if user.admin?
      user.can :manage, Player
      user.can :manage, Team
      user.can :manage, RosterSpot
      user.can :manage, User
    end
  end
end