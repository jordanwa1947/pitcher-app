class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.float :longitude
      t.float :latitude
      t.string :yelp_link
      t.string :phone_number
      t.string :address
      t.string :name
      t.string :image
    end
  end
end
