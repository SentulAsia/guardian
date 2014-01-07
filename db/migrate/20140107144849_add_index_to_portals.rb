class AddIndexToPortals < ActiveRecord::Migration
  def change
  	add_index :portals, :portal_name
  	add_index :portals, :city
  	add_index :portals, :status_string
  	add_index :portals, :destruction_date
  	add_index :portals, :destroyed_by
  	add_index :portals, :total_points
  end
end
