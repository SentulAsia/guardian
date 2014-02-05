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

  def self.calculate_hash(data)
    Digest::MD5.hexdigest data.to_json
  end

  def self.json_data(data, hash)
    data.map { |datum|
      {
        :age_points => datum.age_points,
        :agent_name => datum.agent_name,
        :bonus_details => datum.bonus_details,
        :bonus_points => datum.bonus_points,
        :captured_date => datum.captured_date,
        :city => datum.city,
        :created_at => datum.created_at,
        :day_of_150 => datum.day_of_150,
        :destroyed_by => datum.destroyed_by,
        :destruction_date => datum.destruction_date,
        :id => datum.id,
        :lat_coordinate => datum.lat_coordinate,
        :link => datum.link,
        :lng_coordinate => datum.lng_coordinate,
        :location => datum.location,
        :note => datum.note,
        :portal_guid => datum.portal_guid,
        :portal_name => datum.portal_name,
        :status_string => datum.status_string,
        :id => datum.id,
        :total_points => datum.total_points,
        :updated_at => datum.updated_at,
        :hash => hash
      }
    }
  end

  def calculate_points
    self.destruction_date = self.destruction_date - 8.hours unless self.destruction_date.blank?
    if self.status_string == 'Destroyed'
      age = ((Time.now - self.captured_date) / 86400).to_i
      bonus = 0
      bonus = self.bonus_points = 1 if (83..89).include?(age)
      bonus = self.bonus_points = 2 if (143..150).include?(age)
      self.age_points = 1
      self.total_points = 1 + bonus
      self.destroyed_by = '__JARVIS__' if self.destroyed_by.blank?
    end
  end

  def self.search(search,type)
    if search and Rails.env.development?
      where("#{type} LIKE ? collate nocase", "%#{search}%")
    elsif search and Rails.env.production?
      where("#{type} ILIKE ?", "%#{search}%")
    else
      scoped
    end
  end

  private

  def portal_age_above_20_days
     errors.add(:captured_date, "Portal age below 20 days") unless
     ((Time.now - self.captured_date) / 86400).to_i > 19
  end
end
