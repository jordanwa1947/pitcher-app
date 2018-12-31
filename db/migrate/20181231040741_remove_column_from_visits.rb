class RemoveColumnFromVisits < ActiveRecord::Migration[5.2]

  def change
    remove_column :visits, :yelp_id
  end

end
