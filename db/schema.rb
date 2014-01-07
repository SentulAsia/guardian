# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140107144849) do

  create_table "portals", :force => true do |t|
    t.string    "agent_name",       :null => false
    t.string    "portal_name",      :null => false
    t.timestamp "captured_date",    :null => false
    t.string    "link"
    t.decimal   "lng_coordinate",   :null => false
    t.decimal   "lat_coordinate",   :null => false
    t.timestamp "day_of_150"
    t.string    "location",         :null => false
    t.string    "city"
    t.text      "note"
    t.string    "status_string"
    t.timestamp "destruction_date"
    t.string    "destroyed_by"
    t.integer   "age_points"
    t.integer   "bonus_points"
    t.integer   "total_points"
    t.string    "bonus_details"
    t.string    "portal_guid"
    t.timestamp "created_at",       :null => false
    t.timestamp "updated_at",       :null => false
  end

  add_index "portals", ["agent_name"], :name => "index_portals_on_agent_name"
  add_index "portals", ["captured_date"], :name => "index_portals_on_captured_date"
  add_index "portals", ["city"], :name => "index_portals_on_city"
  add_index "portals", ["destroyed_by"], :name => "index_portals_on_destroyed_by"
  add_index "portals", ["destruction_date"], :name => "index_portals_on_destruction_date"
  add_index "portals", ["location"], :name => "index_portals_on_location"
  add_index "portals", ["portal_name"], :name => "index_portals_on_portal_name"
  add_index "portals", ["status_string"], :name => "index_portals_on_status_string"
  add_index "portals", ["total_points"], :name => "index_portals_on_total_points"

end
