class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :position, :score, :salary, :points, :rebounds, :assists, :blocks, :steals, :games_played, :value, :team_count

  def value
    object.value
  end

  def team_count
    object.teams.count
  end
end
