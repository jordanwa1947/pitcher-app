class CreateVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.references :user, foreign_key: true
      t.references :restaurant, foreign_key: true
      t.string :yelp_id

      t.timestamps
    end
  end
end
