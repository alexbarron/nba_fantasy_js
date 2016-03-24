class League < ActiveRecord::Base
  has_many :teams
  belongs_to :user

  def commissioner_name
    self.user.name
  end

  def self.most_popular_leagues
    League.all.max_by(10) do |league|
      league.teams.count
    end
  end
end
