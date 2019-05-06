require 'nokogiri'
require 'open-uri'

url = "https://www.amsterdamrollerderby.nl/wp-content/uploads/2017/02/cropped-logo-transparent-invert-grey-small.png"

namespace :image do
  desc "Scrap image"

  task test: :environment do

    open('app/assets/images/image.png', 'wb') do |file|
      file << open(url).read
    end
  end
end
