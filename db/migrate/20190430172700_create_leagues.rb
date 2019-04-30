class CreateLeagues < ActiveRecord::Migration[5.2]
  def change
    create_table :leagues do |t|
      t.string :name
      t.string :country
      t.string :city
      t.float :lat
      t.float :long
      t.string :logo

      t.timestamps
    end
  end
end
