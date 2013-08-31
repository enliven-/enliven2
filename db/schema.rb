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

ActiveRecord::Schema.define(:version => 20130830135227) do

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

  create_table "stackoverflow_answers", :force => true do |t|
    t.integer  "stackoverflow_question_id"
    t.datetime "answer_created_at"
    t.datetime "last_edit_date"
    t.datetime "last_activity_date"
    t.integer  "score"
    t.boolean  "is_accepted"
    t.integer  "up_vote_count"
    t.integer  "down_vote_count"
    t.integer  "stackoverflow_profile_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "stackoverflow_badges", :force => true do |t|
    t.string   "name"
    t.string   "rank"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "badge_type"
  end

  create_table "stackoverflow_comments", :force => true do |t|
    t.integer  "stackoverflow_profile_id"
    t.integer  "stackoverflow_post_id"
    t.integer  "score"
    t.datetime "creation_date"
    t.boolean  "edited"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "stackoverflow_profile_badges", :force => true do |t|
    t.integer  "stactoverflow_profile_id"
    t.integer  "stackoverflow_badge_id"
    t.integer  "award_count"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "stackoverflow_profile_id"
  end

  create_table "stackoverflow_profiles", :force => true do |t|
    t.string   "profile_type"
    t.datetime "creation_date"
    t.string   "name"
    t.integer  "reputation_change_day"
    t.integer  "reputation_change_week"
    t.integer  "reputation_change_month"
    t.integer  "reputation_change_quarter"
    t.integer  "reputation_change_year"
    t.integer  "age"
    t.datetime "last_access_date"
    t.datetime "last_modified_date"
    t.boolean  "is_employee"
    t.string   "blog"
    t.string   "location"
    t.integer  "account_id"
    t.integer  "accept_rate"
    t.integer  "gold_badge_count"
    t.integer  "silver_badge_count"
    t.integer  "bronze_badge_count"
    t.integer  "reputation"
    t.integer  "answer_count"
    t.integer  "question_count"
    t.integer  "view_count"
    t.text     "about_me"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "stackoverflow_questions", :force => true do |t|
    t.datetime "last_edit_date"
    t.datetime "question_created_at"
    t.datetime "last_activity_date"
    t.integer  "score"
    t.integer  "answer_count"
    t.integer  "up_vote_count"
    t.integer  "down_vote_count"
    t.integer  "favorite_count"
    t.integer  "view_count"
    t.integer  "stackoverflow_profile_id"
    t.boolean  "is_answered"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "stackoverflow_taggings", :force => true do |t|
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "stackoverflow_taggable_id"
    t.string   "stackoverflow_taggable_type"
    t.integer  "stackoverflow_tag_id"
  end

  create_table "stackoverflow_tags", :force => true do |t|
    t.string   "name"
    t.integer  "count"
    t.boolean  "has_synonyms"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
