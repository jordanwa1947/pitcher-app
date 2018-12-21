class CreateWishlists < ActiveRecord::Migration[5.2]
  def change
    create_table :wishlists do |t|
      t.references :user, foreign_key: true
      t.integer :rank, null: false, default: 0

      t.timestamps
    end
  end
end
