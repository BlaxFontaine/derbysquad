require 'rest-client'

namespace :NZ_scrap do
  desc "Scrap leagues in the region NZ from flattrackstat"

  task scrap: :environment do

    # There are 5 pages on which we iterate
    [0].each do |page_number|
      url = "http://flattrackstats.com/teams/results/taxonomy%3A40%2C11%2C49?page=#{page_number}"
      html_file = open(url).read.encode!('UTF-8', 'UTF-8', :invalid => :replace)
      html_doc = Nokogiri::HTML(html_file)

      # In the teams table we look for the data we need
      html_doc.search('tr').each_with_index do |element, i|

        # First line of the table is a table head so we skip it
        next if i == 0
        next if i == 1

        puts "scrapping...."
        # BASIC LEAGUE ELEMENTS : NAME AND URL
        league_name = element.search('.views-field-title a').text.strip
        path = element.search('.views-field-title a').attribute('href')
        lead_fts_code = path.value.match(/\d+/)[0]
        league_url = "http://flattrackstats.com#{path}"
        league_html_file = open(league_url).read.encode!('UTF-8', 'UTF-8', :invalid => :replace)
        league_html_doc = Nokogiri::HTML(league_html_file)

        logo = league_html_doc.search('.logo img').attribute('src').value
        location = league_html_doc.search('.large').text
        location = location.sub(/, [A-Z]{2,3}/, "")
        # LOCATION WITH ALGOLIA
        algolia_location = JSON.parse((RestClient.post "https://places-dsn.algolia.net/1/places/query", {'query' => "#{location}", type: "city",  countries: ["nz"]}.to_json, {content_type: :json, accept: :json}))
        response = algolia_location["hits"]
        if algolia_location["nbHits"].positive? # If the location doesn't exist, the league won't be created
          response[0]["country"]["en"].nil? ? country = response[0]["country"]["default"] : country = response[0]["country"]["en"]
          if response[0]["city"].nil?
            response[0]["locale_names"]["en"].nil? ? city = response[0]["locale_names"]["default"][0] : city = response[0]["locale_names"]["en"][0]
          else
            response[0]["city"]["en"].nil? ? city = response[0]["city"]["default"][0] : city = response[0]["city"]["en"][0]
          end
          latitude = response[0]["_geoloc"]["lat"]
          longitude = response[0]["_geoloc"]["lng"]
          logo_name = league_name.gsub(" ", "_").gsub("/", "_").downcase
          data = RestClient.get(logo).body
          path = "#{logo_name}.jpg"
          File.write("app/assets/images/#{path}", data, mode: "wb")
          # From there, we create a new league
          league = League.new(name: league_name,
                              city: city,
                              country: country,
                              logo: path,
                              lat: latitude,
                              long: longitude,
                              region: "NZ")

          if league.valid?
            league.save!
            puts "LEAGUE CREATED: #{league.name}"
            var_inter = league_html_doc.search('.teamname').text.match(/"(.*)"/)[1]
            if var_inter.match(/\(([^()]+)\)/).nil?
              lead_team_name = var_inter
            else
              lead_team_name = var_inter.match(/\(([^()]+)\)/)[1].capitalize
            end
            # Once the league has been created we create the teams of that league


            lead_team = Team.new(name: lead_team_name, league_id: league.id, fts_code: lead_fts_code)
            if lead_team.valid?
              puts "TEAM CREATED: #{lead_team.name}"
              lead_team.save!
              league_html_doc.search('.relatedteams a').each do |element|
                puts "scrapping...."
                unless element.attributes["class"].value == "disbanded"
                  secondary_team_name = element.text.strip
                  secondary_fts_code = element.attribute('href').value.match(/\d+/)[0]
                  secondary_team = Team.new(name: secondary_team_name, league_id: league.id, fts_code: secondary_fts_code)
                  if secondary_team.valid?
                    secondary_team.save!
                    puts "TEAM CREATED: #{secondary_team.name}"
                  end
                end
              end
            end
          end
        end
        puts "CREATED #{League.where(region: "NZ").count} LEAGUES!"
        puts "CREATED #{Team.count} TEAMS!"
      end
    end
  end
end
