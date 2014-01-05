class ChangeStringToDateTime < ActiveRecord::Migration
  def change
  	change_column :portals, :captured_date, :datetime
  	change_column :portals, :day_of_150, :datetime
  	change_column :portals, :destruction_date, :datetime
  end
end
