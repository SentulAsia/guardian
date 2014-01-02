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

ActiveRecord::Schema.define(:version => 20140102051436) do

  create_table "portals", :force => true do |t|
    t.string   "agent_name",       :null => false
    t.string   "portal_name",      :null => false
    t.string   "captured_date",    :null => false
    t.string   "link"
    t.decimal  "lng_coordinate",   :null => false
    t.decimal  "lat_coordinate",   :null => false
    t.string   "day_of_150"
    t.string   "location",         :null => false
    t.string   "city"
    t.text     "note"
    t.string   "status_string"
    t.string   "destruction_date"
    t.string   "destroyed_by"
    t.integer  "age_points"
    t.integer  "bonus_points"
    t.integer  "total_points"
    t.string   "bonus_details"
    t.string   "portal_guid"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "portals", ["agent_name"], :name => "index_portals_on_agent_name"
  add_index "portals", ["captured_date"], :name => "index_portals_on_captured_date"
  add_index "portals", ["location"], :name => "index_portals_on_location"

end
