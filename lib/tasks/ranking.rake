namespace :ranking do
  desc "Update teams ranking"

  task update_all: :environment do
    Team.all.each do |team|
    # team = Team.first
      ranking_url = "http://flattrackstats.com/rankings/women"
      ranking_html_file = open(ranking_url).read.encode!('UTF-8', 'UTF-8', :invalid => :replace)
      ranking_html_doc = Nokogiri::HTML(ranking_html_file)
      ranking_html_doc.search('.rankingscontainer.rightflush tr').each_with_index do |element, i|
        next if i == 0
        num = element.search('a')[0].attributes['href'].value.match(/\d+/)[0].to_i
        next if num != team.fts_code

        ranking = element.children.children[0].text.delete('.').to_i
        team.update(ranking: ranking, ranking_date: Date.today)
        puts "#{team.league.name} - #{team.name} updated!"
      end
    end
  end
end
