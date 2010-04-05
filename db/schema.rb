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

ActiveRecord::Schema.define(:version => 20100330020842) do

  create_table "events", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "event_state",                                                               :null => false
    t.datetime "registration_start_date_time"
    t.datetime "registration_end_date_time"
    t.datetime "start_date_time",                                                           :null => false
    t.datetime "end_date_time",                                                             :null => false
    t.string   "time_zone",                    :limit => 40
    t.integer  "registration_fee",             :limit => 10, :precision => 10, :scale => 0, :null => false
    t.text     "description",                                                               :null => false
    t.integer  "max_participants"
    t.text     "disclaimer",                                                                :null => false
    t.string   "address_line_1",                                                            :null => false
    t.string   "address_line_2"
    t.string   "city",                         :limit => 50,                                :null => false
    t.string   "state",                        :limit => 2,                                 :null => false
    t.string   "postal_code",                  :limit => 10,                                :null => false
    t.integer  "parent_id"
    t.integer  "minimum_age_to_register"
    t.integer  "minimum_age_to_participate"
    t.string   "latitude",                     :limit => 40
    t.string   "longitude",                    :limit => 40
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
    t.string   "description",                                  :null => false
    t.integer  "number_of_volunteers_required",                :null => false
    t.integer  "event_id",                                     :null => false
    t.datetime "start_date_time"
    t.datetime "end_date_time"
    t.string   "lat",                           :limit => 50
    t.string   "lng",                           :limit => 50
    t.string   "address_line_1",                :limit => 100
    t.string   "address_line_2",                :limit => 100
    t.string   "city",                          :limit => 50
    t.string   "state",                         :limit => 10
    t.string   "postal_code",                   :limit => 9
    t.string   "title",                         :limit => 50
  end

  add_index "jobs", ["event_id"], :name => "index_jobs_on_event_id"

  create_table "map_data_points", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",       :limit => 20
    t.integer  "map_id",                   :null => false
  end

  create_table "maps", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",      :limit => 50, :null => false
    t.integer  "event_id",                 :null => false
  end

  create_table "signups", :force => true do |t|
    t.string   "signup_state"
    t.boolean  "accepted_terms"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id",       :null => false
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                            :null => false
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
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
    t.date     "birthday_date",                                    :null => false
  end

end
