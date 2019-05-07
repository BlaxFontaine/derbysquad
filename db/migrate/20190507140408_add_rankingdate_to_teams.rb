class AddRankingdateToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :ranking_date, :date
  end
end
