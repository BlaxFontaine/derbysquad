require 'rest-client'

namespace :algolia do
  desc "Scrap leagues in the region Europe from flattrackstat"

  task scrap: :environment do
    location = "Dieppe, NB, Canada"
    location = location.sub(/, [A-Z]{2}, Canada/, "")
    p location
    p JSON.parse((RestClient.post "https://places-dsn.algolia.net/1/places/query", { 'query' => "#{location}", type: "city", countries: ["ca"] }.to_json, { content_type: :json, accept: :json }))

  end
end
