require 'json'

namespace :latina_save do
  desc "Save Latin America leagues and teams into a json"
  task json: :environment do
    leagues = League.where(region: "Latin America").all
    output_leagues = { leagues: [] }
    leagues.each do |league|
      output_teams = []
      league.teams.each do |team|
        output_teams << {
          team: team.name,
          ranking: team.ranking,
          ranking_date: team.ranking_date,
          fts_code: team.fts_code
        }
      end

      output_leagues[:leagues] << {
        league: league.name,
        country: league.country,
        city: league.city,
        lat: league.lat,
        long: league.long,
        region: league.region,
        logo: league.logo,
        teams: output_teams
      }
    end
    output = 'latin_america.json'
    File.open(output, 'wb') do |file|
      file.write(JSON.generate(output_leagues))
    end
  end
end

