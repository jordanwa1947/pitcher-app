class RemoveColumnFromWishlist < ActiveRecord::Migration[5.2]

  def change
    remove_column :wishlists, :yelp_id
  end

end
