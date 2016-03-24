# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'

jimbo = User.create(name: "Jimbo", email: "email@email.com", password: "password", password_confirmation: "password")
Team.create(name: "Warriors", user_id: jimbo.id)

janebo = User.create(name: "Janebo", email: "email2@email.com", password: "password", password_confirmation: "password")
Team.create(name: "Lakers", user_id: janebo.id)

team_urls = [
  "http://www.basketball-reference.com/teams/CLE/2016.html",
  "http://www.basketball-reference.com/teams/TOR/2016.html",
  "http://www.basketball-reference.com/teams/MIA/2016.html",
  "http://www.basketball-reference.com/teams/GSW/2016.html",
  "http://www.basketball-reference.com/teams/SAS/2016.html",
  "http://www.basketball-reference.com/teams/OKC/2016.html"
]

 def make_players(team_url)
    page = Nokogiri::HTML(open(team_url))
    players = page.css("table#roster tr")
    players.drop(1).each do |player|
      data_array = player.text.split("\n").map {|x| x.strip}
      name = data_array[2]
      position = data_array[3]
      player_url = "http://www.basketball-reference.com" + player.css("a").first["href"]

      new_player = Player.find_or_create_by({name: name, position: position, player_url: player_url})
      new_player.update_info
    end
  end

team_urls.each do |team_url|
  make_players(team_url)
end
