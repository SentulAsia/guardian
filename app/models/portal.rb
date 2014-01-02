class Portal < ActiveRecord::Base
  attr_accessible :day_of_150, :age_points, :agent_name, :bonus_details, :bonus_points, :captured_date, :city, :destroyed_by, :destruction_date, :lat_coordinate, :link, :lng_coordinate, :location, :note, :portal_guid, :portal_name, :status_string, :total_points
end
