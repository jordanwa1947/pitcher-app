class AddCordinatesToMainAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :main_addresses, :longitude, :float
    add_column :main_addresses, :latitude, :float 
  end
end
