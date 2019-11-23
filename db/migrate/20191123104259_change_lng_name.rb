class ChangeLngName < ActiveRecord::Migration[5.2]
  def change
    rename_column :leagues, :long, :lng
  end
end
