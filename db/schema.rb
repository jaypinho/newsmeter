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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150517212546) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authorizations", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "friend_id"
    t.string   "sharing_scope", default: "restricted"
    t.integer  "user_id",       index: {name: "index_friendships_on_user_id"}
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "keywords", force: :cascade do |t|
    t.string   "keyword",    limit: 255, index: {name: "index_keywords_on_keyword", unique: true, case_sensitive: false}
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_keywords", force: :cascade do |t|
    t.integer  "page_id",    index: {name: "index_page_keywords_on_page_id"}
    t.integer  "keyword_id", index: {name: "index_page_keywords_on_keyword_id"}
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_views", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "actual_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "page_id",    index: {name: "index_page_views_on_page_id"}
    t.datetime "ended_at"
    t.string   "ip_address"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "canonical_url", limit: 255, index: {name: "index_pages_on_canonical_url", unique: true}
    t.string   "title",         limit: 255
    t.string   "page_type",     limit: 255
    t.string   "author",        limit: 255
    t.integer  "site_id",       index: {name: "index_pages_on_site_id"}
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "sites", force: :cascade do |t|
    t.string   "domain",       limit: 255, index: {name: "index_sites_on_domain", unique: true}
    t.string   "organization", limit: 255
    t.string   "nationality",  limit: 255
    t.string   "language",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "finished_tour", default: false
  end

  add_foreign_key "friendships", "users"
end
