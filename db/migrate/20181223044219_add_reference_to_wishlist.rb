class AddReferenceToWishlist < ActiveRecord::Migration[5.2]
  def change
    add_reference :wishlists, :restaurant, foreign_key: true
  end
end
