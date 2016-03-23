# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

jimbo = User.create(name: "Jimbo", email: "email@email.com", password: "password", password_confirmation: "password")
Team.create(name: "Warriors", user_id: jimbo.id)

janebo = User.create(name: "Janebo", email: "email2@email.com", password: "password", password_confirmation: "password")
Team.create(name: "Lakers", user_id: janebo.id)
