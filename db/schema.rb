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

ActiveRecord::Schema.define(:version => 20090220140257) do

  create_table "bill_items", :force => true do |t|
    t.string   "name"
    t.date     "date"
    t.integer  "bill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bill_participants", :force => true do |t|
    t.string   "name"
    t.integer  "bill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "party_size"
  end

  create_table "bill_payments", :force => true do |t|
    t.integer  "bill_item_id"
    t.integer  "bill_participant_id"
    t.decimal  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bills", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  create_table "visitor_bills", :id => false, :force => true do |t|
    t.integer  "bill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visitor_id"
  end

  create_table "visitors", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
    t.string   "locale"
  end

end
