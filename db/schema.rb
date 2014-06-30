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

ActiveRecord::Schema.define(:version => 20140630124045) do

  create_table "comments", :force => true do |t|
    t.string   "content"
    t.integer  "daily_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["daily_id"], :name => "index_comments_on_daily_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "dailies", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.datetime "date"
  end

  add_index "dailies", ["user_id"], :name => "index_dailies_on_user_id"

  create_table "documents", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "category"
    t.integer  "paper_id"
    t.integer  "patent_id"
    t.integer  "thesis_id"
  end

  add_index "documents", ["project_id"], :name => "index_documents_on_project_id"
  add_index "documents", ["user_id"], :name => "index_documents_on_user_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "university"
    t.string   "school"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
  end

  create_table "histories", :force => true do |t|
    t.integer  "category"
    t.integer  "detail_id"
    t.integer  "action"
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "histories", ["user_id"], :name => "index_histories_on_user_id"

  create_table "papers", :force => true do |t|
    t.string   "title"
    t.string   "magazine"
    t.integer  "status"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "papers", ["user_id"], :name => "index_papers_on_user_id"

  create_table "patents", :force => true do |t|
    t.string   "title"
    t.string   "agency"
    t.integer  "status"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "patents", ["user_id"], :name => "index_patents_on_user_id"

  create_table "plans", :force => true do |t|
    t.string   "title"
    t.text     "note"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.integer  "status"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "plans", ["user_id"], :name => "index_plans_on_user_id"

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.integer  "category"
    t.string   "source"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.integer  "status"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "projects", ["user_id"], :name => "index_projects_on_user_id"

  create_table "theses", :force => true do |t|
    t.string   "title"
    t.text     "abstract"
    t.string   "keywords"
    t.integer  "status"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "theses", ["user_id"], :name => "index_theses_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "group_id"
    t.string   "name"
    t.integer  "identity"
    t.string   "phone"
    t.integer  "grade"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
