# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100307041027) do

  create_table "events", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "event_state",                                :null => false
    t.datetime "registration_start_date_time"
    t.datetime "registration_end_date_time"
    t.datetime "start_date_time",                            :null => false
    t.datetime "end_date_time",                              :null => false
    t.string   "time_zone",                    :limit => 40
  end

  create_table "events_jobs_volunteers", :id => false, :force => true do |t|
    t.integer "event_id", :null => false
    t.integer "user_id",  :null => false
    t.integer "job_id",   :null => false
  end

  add_index "events_jobs_volunteers", ["event_id"], :name => "index_events_jobs_volunteers_on_event_id"
  add_index "events_jobs_volunteers", ["job_id"], :name => "index_events_jobs_volunteers_on_job_id"
  add_index "events_jobs_volunteers", ["user_id"], :name => "index_events_jobs_volunteers_on_user_id"

  create_table "events_registrants", :id => false, :force => true do |t|
    t.integer "event_id", :null => false
    t.integer "user_id",  :null => false
  end

  add_index "events_registrants", ["event_id"], :name => "index_events_registrants_on_event_id"
  add_index "events_registrants", ["user_id"], :name => "index_events_registrants_on_user_id"

  create_table "jobs", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description",         :null => false
    t.integer  "number_of_volnteers", :null => false
    t.integer  "location_id",         :null => false
    t.integer  "event_id",            :null => false
    t.datetime "start_date_time"
    t.datetime "end_date_time"
  end

  add_index "jobs", ["event_id"], :name => "index_jobs_on_event_id"

  create_table "locations", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "map_url",                                                   :null => false
    t.string   "title",       :limit => 50,                                 :null => false
    t.string   "description", :limit => 200,                                :null => false
    t.integer  "event_id",                                                  :null => false
    t.integer  "job_id",                                                    :null => false
    t.integer  "lat",         :limit => 10,  :precision => 10, :scale => 0
    t.integer  "long",        :limit => 10,  :precision => 10, :scale => 0
  end

  add_index "locations", ["event_id", "job_id"], :name => "index_locations_on_event_id_and_job_id"
  add_index "locations", ["event_id"], :name => "index_locations_on_event_id"
  add_index "locations", ["job_id"], :name => "index_locations_on_job_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                            :null => false
    t.string   "crypted_password",                                 :null => false
    t.string   "password_salt",                                    :null => false
    t.string   "persistence_token",                                :null => false
    t.string   "single_access_token",                              :null => false
    t.string   "perishable_token",                                 :null => false
    t.integer  "login_count",                       :default => 0, :null => false
    t.integer  "failed_login_count",                :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_state",                                       :null => false
    t.string   "default_time_zone",   :limit => 40
  end

end
