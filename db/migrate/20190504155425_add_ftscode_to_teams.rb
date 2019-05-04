class AddFtscodeToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :fts_code, :integer
  end
end
