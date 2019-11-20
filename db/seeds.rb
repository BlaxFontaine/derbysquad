# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'

League.destroy_all

jsons = ['europe.json', 'latin_america.json', 'canada.json', 'usa.json', 'australia.json', 'nz.json', 'pacific.json']

jsons.each do |json|
  serialized_input = File.read(json)
  input = JSON.parse(serialized_input)
  input_leagues = input['leagues']
  # p input_leagues
  input_leagues.each do |league|
    new_league = {}
    new_league[:name] = league['name']
    new_league[:country] = league['country']
    new_league[:city] = league['city']
    new_league[:lat] = league['lat']
    new_league[:long] = league['long']
    new_league[:region] = league['region']
    new_league[:logo] = league['logo']
    League.create!(new_league)
    league['teams'].each do |team|
      new_team = {}
      new_team[:name] = team['name']
      new_team[:ranking] = team['ranking']
      new_team[:ranking_date] = team['ranking_date']
      new_team[:fts_code] = team['fts_code']
      new_team[:league] = League.last
      Team.create!(new_team)
    end
  end
end
