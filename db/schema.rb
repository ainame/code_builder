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

ActiveRecord::Schema.define(:version => 6) do

  create_table "affiliations", :force => true do |t|
    t.integer  "package_id",  :null => false
    t.integer  "template_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "builder_enviroments", :force => true do |t|
    t.string   "access_token", :limit => 6, :null => false
    t.integer  "package_id"
    t.text     "params_json"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "name"
    t.text     "description"
  end

  add_index "builder_enviroments", ["access_token"], :name => "index_builder_enviroments_on_access_token", :unique => true

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "packages", :force => true do |t|
    t.string   "name",         :null => false
    t.string   "access_token", :null => false
    t.integer  "category_id",  :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "templates", :force => true do |t|
    t.string   "access_token", :limit => 6, :null => false
    t.string   "name",                      :null => false
    t.text     "body",                      :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.text     "description"
  end

  add_index "templates", ["access_token"], :name => "index_templates_on_access_token", :unique => true

end
