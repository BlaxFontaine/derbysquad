class AddRegionToLeagues < ActiveRecord::Migration[5.2]
  def change
    add_column :leagues, :region, :string
  end
end
