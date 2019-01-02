class AddSearchedAddressToWishlist < ActiveRecord::Migration[5.2]
  def change
    add_column :wishlists, :searched_address, :string
    add_column :wishlists, :longitude, :float
    add_column :wishlists, :latitude, :float 
  end
end
