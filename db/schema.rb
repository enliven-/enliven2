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

ActiveRecord::Schema.define(:version => 20130827120448) do

  create_table "github_commits", :force => true do |t|
    t.string   "sha"
    t.string   "committer"
    t.datetime "commit_created_at"
    t.integer  "additions"
    t.integer  "deletions"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "github_repo_id"
  end

  create_table "github_gists", :force => true do |t|
    t.datetime "gist_created_at"
    t.string   "language"
    t.integer  "size"
    t.text     "forkers"
    t.boolean  "public"
    t.integer  "github_profile_id"
    t.integer  "github_gist_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "github_profiles", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "name"
    t.integer  "github_id"
    t.string   "company"
    t.string   "blog"
    t.string   "location"
    t.boolean  "hireable"
    t.text     "bio"
    t.integer  "public_repos_count"
    t.integer  "public_gists_count"
    t.integer  "followers_count"
    t.integer  "following_count"
    t.boolean  "fetched"
    t.text     "followers"
    t.text     "following"
    t.datetime "profile_created_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "github_repos", :force => true do |t|
    t.integer  "repo_id"
    t.string   "full_name"
    t.text     "description"
    t.boolean  "private",           :default => false
    t.boolean  "fork"
    t.string   "language"
    t.integer  "forks_count"
    t.integer  "watchers_count"
    t.integer  "size"
    t.text     "watchers"
    t.text     "contributors"
    t.text     "collaborators"
    t.text     "forkers"
    t.datetime "repo_created_at"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "github_profile_id"
  end

  create_table "profiles", :force => true do |t|
    t.string   "email"
    t.integer  "github_profile_id"
    t.integer  "so_profile_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

end
