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

ActiveRecord::Schema.define(version: 20150910142255) do

  create_table "member_locations", force: :cascade do |t|
    t.integer  "member_id",      limit: 4
    t.string   "dx_number",      limit: 50
    t.string   "contact_phone",  limit: 50
    t.string   "contact_mobile", limit: 50
    t.string   "fax",            limit: 50
    t.string   "website",        limit: 255
    t.text     "address",        limit: 65535
    t.string   "town",           limit: 100
    t.string   "county",         limit: 100
    t.string   "postcode",       limit: 10
    t.string   "email",          limit: 200
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.float    "latitude",       limit: 24
    t.float    "longitude",      limit: 24
  end

  add_index "member_locations", ["member_id"], name: "index_member_locations_on_member_id", using: :btree

  create_table "member_monthly_reports", force: :cascade do |t|
    t.integer  "member_id",            limit: 4
    t.date     "date",                                       null: false
    t.integer  "view_count",           limit: 4, default: 0, null: false
    t.integer  "search_results_count", limit: 4, default: 0, null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "member_monthly_reports", ["member_id"], name: "index_member_monthly_reports_on_member_id", using: :btree

  create_table "member_page_views", force: :cascade do |t|
    t.integer  "member_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "member_page_views", ["member_id"], name: "index_member_page_views_on_member_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.integer  "contact_id",              limit: 4
    t.string   "status",                  limit: 7
    t.string   "role",                    limit: 8
    t.string   "email",                   limit: 200
    t.string   "title",                   limit: 10
    t.string   "firstname",               limit: 100
    t.string   "lastname",                limit: 100
    t.string   "username",                limit: 255
    t.string   "password",                limit: 200
    t.text     "notes",                   limit: 65535
    t.string   "forgotten_hash",          limit: 32
    t.integer  "lastlogin",               limit: 4
    t.integer  "created",                 limit: 4
    t.integer  "modified",                limit: 4
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "member_page_views_count", limit: 4,     default: 0
  end

  create_table "membership_details", force: :cascade do |t|
    t.integer  "member_id",                  limit: 4
    t.string   "country_code",               limit: 5
    t.string   "in_practice",                limit: 1
    t.string   "is_admin",                   limit: 1
    t.string   "is_member",                  limit: 1
    t.string   "is_student",                 limit: 1
    t.string   "is_council_member",          limit: 1
    t.string   "is_treasurer",               limit: 1
    t.string   "is_secretary",               limit: 1
    t.string   "is_education_secretary",     limit: 1
    t.string   "vice_president",             limit: 1
    t.string   "vice_president_date",        limit: 64
    t.string   "president",                  limit: 1
    t.string   "president_date",             limit: 64
    t.string   "past_president",             limit: 1
    t.string   "past_president_date",        limit: 64
    t.integer  "date_of_election",           limit: 4
    t.string   "membership_class",           limit: 128
    t.string   "faculty_date",               limit: 128
    t.string   "date_joined",                limit: 128
    t.datetime "date_subscription_paid"
    t.string   "date_retired",               limit: 15
    t.string   "date_struck_off_membership", limit: 15
    t.string   "date_died",                  limit: 15
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "membership_details", ["member_id"], name: "index_membership_details_on_member_id", using: :btree

  create_table "notaries_society_uploads", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "optimadmin_administrators", force: :cascade do |t|
    t.string   "username",               limit: 255, null: false
    t.string   "email",                  limit: 255, null: false
    t.string   "role",                   limit: 255, null: false
    t.string   "auth_token",             limit: 255
    t.string   "password_digest",        limit: 255, null: false
    t.string   "password_reset_token",   limit: 255
    t.datetime "password_reset_sent_at"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "optimadmin_administrators", ["auth_token"], name: "index_optimadmin_administrators_on_auth_token", using: :btree
  add_index "optimadmin_administrators", ["email"], name: "index_optimadmin_administrators_on_email", using: :btree
  add_index "optimadmin_administrators", ["username"], name: "index_optimadmin_administrators_on_username", using: :btree

  create_table "optimadmin_documents", force: :cascade do |t|
    t.string   "name",        limit: 255, null: false
    t.string   "document",    limit: 255, null: false
    t.string   "module_name", limit: 255
    t.integer  "module_id",   limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "optimadmin_external_links", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "optimadmin_images", force: :cascade do |t|
    t.string   "name",        limit: 255, null: false
    t.string   "image",       limit: 255, null: false
    t.string   "module_name", limit: 255
    t.integer  "module_id",   limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "optimadmin_links", force: :cascade do |t|
    t.string   "menu_resource_type", limit: 255
    t.integer  "menu_resource_id",   limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "optimadmin_menu_item_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   limit: 4, null: false
    t.integer "descendant_id", limit: 4, null: false
    t.integer "generations",   limit: 4, null: false
  end

  add_index "optimadmin_menu_item_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "menu_item_anc_desc_idx", unique: true, using: :btree
  add_index "optimadmin_menu_item_hierarchies", ["descendant_id"], name: "menu_item_desc_idx", using: :btree

  create_table "optimadmin_menu_items", force: :cascade do |t|
    t.string   "menu_name",       limit: 100
    t.string   "name",            limit: 100
    t.integer  "parent_id",       limit: 4
    t.boolean  "deletable",                   default: true
    t.boolean  "new_window",                  default: false
    t.string   "title_attribute", limit: 100
    t.integer  "position",        limit: 4,   default: 0
    t.integer  "link_id",         limit: 4
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "optimadmin_menu_items", ["link_id"], name: "index_optimadmin_menu_items_on_link_id", using: :btree

  create_table "optimadmin_module_pages", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "route",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "optimadmin_site_settings", force: :cascade do |t|
    t.string "key",         limit: 255
    t.string "value",       limit: 255
    t.string "environment", limit: 255
  end

  create_table "search_results", force: :cascade do |t|
    t.integer  "search_id",          limit: 4
    t.integer  "member_location_id", limit: 4
    t.float    "distance",           limit: 24
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "search_results", ["member_location_id"], name: "index_search_results_on_member_location_id", using: :btree
  add_index "search_results", ["search_id"], name: "index_search_results_on_search_id", using: :btree

  create_table "searches", force: :cascade do |t|
    t.string   "first_name",           limit: 255
    t.string   "last_name",            limit: 255
    t.string   "town",                 limit: 255
    t.string   "county",               limit: 255
    t.string   "postcode",             limit: 255
    t.integer  "radius",               limit: 4,   default: 5
    t.boolean  "show_all",                         default: false
    t.integer  "search_results_count", limit: 4,   default: 0
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_foreign_key "member_locations", "members"
  add_foreign_key "member_monthly_reports", "members"
  add_foreign_key "member_page_views", "members"
  add_foreign_key "membership_details", "members"
  add_foreign_key "search_results", "member_locations"
  add_foreign_key "search_results", "searches"
end
