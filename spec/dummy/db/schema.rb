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

ActiveRecord::Schema.define(version: 20171024011956) do

  create_table "fuel_authors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.text     "bio"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "twitter"
    t.string   "github"
    t.string   "dribbble"
    t.date     "start_date"
  end

  create_table "fuel_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",                    null: false
    t.integer  "posts_count", default: 0
  end

  add_index "fuel_categories", ["slug"], name: "index_fuel_categories_on_slug", unique: true

  create_table "fuel_faq_categories", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  add_index "fuel_faq_categories", ["slug"], name: "index_fuel_faq_categories_on_slug", unique: true

  create_table "fuel_faq_faq_categories", force: :cascade do |t|
    t.integer  "faq_id"
    t.integer  "faq_category_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "fuel_faqs", force: :cascade do |t|
    t.text     "question"
    t.text     "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fuel_post_tags", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fuel_posts", force: :cascade do |t|
    t.string   "author"
    t.text     "content"
    t.string   "title"
    t.string   "slug"
    t.boolean  "published",                   default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "featured_image_url"
    t.text     "teaser"
    t.string   "featured_image_file_name"
    t.string   "featured_image_content_type"
    t.integer  "featured_image_file_size"
    t.datetime "featured_image_updated_at"
    t.string   "seo_title"
    t.text     "seo_description"
    t.integer  "author_id"
    t.datetime "published_at"
    t.string   "format",                      default: "html"
    t.integer  "category_id"
  end

  add_index "fuel_posts", ["slug"], name: "index_fuel_posts_on_slug", unique: true

  create_table "fuel_tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",       null: false
  end

  add_index "fuel_tags", ["slug"], name: "index_fuel_tags_on_slug", unique: true

end
