require 'json'

namespace :leagues_save do
  desc "Save leagues leagues and teams into a json"
  task json: :environment do
    leagues = League.all
    output_leagues = { leagues: [] }
    leagues.each do |league|
      output_teams = []
      league.teams.each do |team|
        output_teams << {
          name: team.name,
          ranking: team.ranking,
          ranking_date: team.ranking_date,
          fts_code: team.fts_code
        }
      end

      output_leagues[:leagues] << {
        name: league.name,
        country: league.country,
        city: league.city,
        lat: league.lat,
        lng: league.lng,
        region: league.region,
        logo: league.logo,
        teams: output_teams
      }
    end
    output = 'leagues.json'
    File.open(output, 'wb') do |file|
      file.write(JSON.generate(output_leagues))
    end
  end
end
