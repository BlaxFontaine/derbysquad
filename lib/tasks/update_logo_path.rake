namespace :update_path do
  desc "update the logo path with just the image name"
  task update: :environment do
    League.all.each do |league|
      puts "Initial path: #{league.logo}"
      league.logo = league.logo.gsub("app/assets/images/", "")
      league.save
      puts "New path: #{league.logo}"
    end
  end
end
