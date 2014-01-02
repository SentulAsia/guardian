class Portal < ActiveRecord::Base
  attr_accessible :day_of_150, :age_points, :agent_name, :bonus_details, :bonus_points, :captured_date, :city, :destroyed_by, :destruction_date, :lat_coordinate, :link, :lng_coordinate, :location, :note, :portal_guid, :portal_name, :status_string, :total_points

  validates :agent_name, :presence => true
  validates :portal_name, :presence => true
  validates :captured_date, :presence => true
  validates :location, :presence => true
  validates :lng_coordinate, :presence => true, :numericality => { :only_integer => true }, :inclusion => { :in => -360..360, :message => "%{value} is not a valid longitude" }
  validates :lat_coordinate, :presence => true, :numericality => { :only_integer => true }, :inclusion => { :in => -360..360, :message => "%{value} is not a valid latitude" }
  validates :portal_guid, :presence => true, :uniqueness => true
end
