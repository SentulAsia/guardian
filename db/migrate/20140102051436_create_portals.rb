class CreatePortals < ActiveRecord::Migration
  def change
    create_table :portals do |t|
      t.string :agent_name, :null => false
      t.string :portal_name, :null => false
      t.string :captured_date, :null => false
      t.string :link
      t.decimal :lng_coordinate, :null => false, :precision => 25, :scale => 21
      t.decimal :lat_coordinate, :null => false, :precision => 25, :scale => 21
      t.string :day_of_150
      t.string :location, :null => false
      t.string :city
      t.text :note
      t.string :status_string
      t.string :destruction_date
      t.string :destroyed_by
      t.integer :age_points
      t.integer :bonus_points
      t.integer :total_points
      t.string :bonus_details
      t.string :portal_guid, :null => false

      t.timestamps
    end
    add_index :portals, :agent_name
    add_index :portals, :captured_date
    add_index :portals, :location
    add_index :portals, :portal_guid, :unique => true
  end
end
