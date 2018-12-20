class CreateMainAddress < ActiveRecord::Migration[5.2]
  def change
    create_table :main_addresses do |t|
      t.references :user, foreign_key: true
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
    end
  end
end
