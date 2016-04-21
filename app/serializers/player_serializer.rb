class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :position, :score, :salary, :points, :rebounds, :assists, :blocks, :steals, :games_played, :value, :team_count, :next_id, :prev_id

  def value
    object.value
  end

  def team_count
    object.teams.count
  end

  def next_id
    object.next ? object.next.id : 0
  end

  def prev_id
    object.prev ? object.prev.id : 0
  end

end
