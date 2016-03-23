class Ability
  include CanCan::Ability

  def initialize(user)

    if user.admin?
      can :manage, :all
    else
      can :read, :all
      can :manage, Team, user_id: user.id
      can :manage, RosterSpot, team_id: user.team.id
    end
  end
end