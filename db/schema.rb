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

ActiveRecord::Schema.define(:version => 20111011232925) do

  create_table "authentications", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "categories_messages", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "message_id"
  end

  create_table "categories_verses", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "verse_id"
  end

  create_table "messages", :force => true do |t|
    t.string   "title"
    t.date     "mdate"
    t.text     "summary"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "speaker_id"
    t.date     "listened_on"
    t.integer  "user_id"
  end

  create_table "messages_verses", :id => false, :force => true do |t|
    t.integer "message_id"
    t.integer "verse_id"
  end

  create_table "speakers", :force => true do |t|
    t.string   "name"
    t.string   "church"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "link"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "verses", :force => true do |t|
    t.string  "ref"
    t.integer "user_id"
  end

end
