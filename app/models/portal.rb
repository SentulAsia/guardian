class Portal < ActiveRecord::Base
  attr_accessor :direction, :page, :search, :sort, :status, :type
  attr_accessible :age_points, :agent_name, :bonus_details, :bonus_points, :captured_date, :city, :day_of_150, :destroyed_by, :destruction_date, :direction, :lat_coordinate, :link, :lng_coordinate, :location, :note, :page, :portal_guid, :portal_name, :search, :sort, :status, :status_string, :total_points, :type

  validates :agent_name, :presence => true
  validates :portal_name, :presence => true
  validates :captured_date, :presence => true
  validates :location, :presence => true
  validates :lng_coordinate, :presence => true, :numericality => true
  validates :lat_coordinate, :presence => true, :numericality => true
  validates :portal_guid, :presence => true, :uniqueness => true
  validate :portal_age_above_20_days

  before_save :calculate_points

  def calculate_points
    self.destruction_date = self.destruction_date - 8.hours unless self.destruction_date.blank?
    self.total_points = 1 if self.status_string == 'Destroyed'
  end

  def self.search(search,type)
      if search
          where("#{type} LIKE ?", "%#{search}%")
      else
          scoped
      end
  end

  private

  def portal_age_above_20_days
     errors.add(:captured_date, "Portal age below 20 days") unless
     ((Time.now - self.captured_date) / 86400).round > 19
  end
end
