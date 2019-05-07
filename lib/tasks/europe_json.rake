require 'json'

namespace :europe_save do
  desc "Save Europe leagues and teams into a json"
  task json: :environment do
    leagues = League.all
    output_leagues = { leagues: [] }
    leagues.each do |league|
      output_teams = []
      league.teams.each do |team|
        output_teams << {
          team_name: team.name,
          ranking: team.ranking,
          fts_code: team.fts_code
        }
      end

      output_leagues[:leagues] << {
        league_name: league.name,
        country: league.country,
        city: league.city,
        latitude: league.lat,
        longitude: league.long,
        region: league.region,
        teams: output_teams
      }
    end
    output = 'europe.json'
    File.open(output, 'wb') do |file|
      file.write(JSON.generate(output_leagues))
    end
  end
end

