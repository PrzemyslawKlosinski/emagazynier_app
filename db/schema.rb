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

ActiveRecord::Schema.define(:version => 20130121215128) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.boolean  "isDefault"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categories", ["user_id"], :name => "index_categories_on_user_id"

  create_table "products", :force => true do |t|
    t.decimal  "summaryQuantityPurchase"
    t.decimal  "summaryQuantitySales"
    t.string   "nameOryginal"
    t.string   "name"
    t.decimal  "quantity"
    t.decimal  "reservedQuantity"
    t.decimal  "quantityMinimum"
    t.decimal  "quantityMaximum"
    t.text     "warningNote"
    t.boolean  "isWarningShow"
    t.text     "description"
    t.binary   "picture"
    t.boolean  "blocked"
    t.integer  "user_id"
    t.integer  "category_id"
    t.integer  "productPrice_id"
    t.decimal  "defaultIncrease"
    t.decimal  "defaultDecrease"
    t.decimal  "defaultVat"
    t.boolean  "actualPriceOnPurchase"
    t.string   "manufacturer"
    t.string   "color"
    t.string   "intended"
    t.string   "location"
    t.string   "size"
    t.string   "shape"
    t.text     "descriptions"
    t.integer  "unit_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "products", ["category_id"], :name => "index_products_on_category_id"
  add_index "products", ["productPrice_id"], :name => "index_products_on_productPrice_id"
  add_index "products", ["unit_id"], :name => "index_products_on_unit_id"
  add_index "products", ["user_id", "created_at"], :name => "index_products_on_user_id_and_created_at"
  add_index "products", ["user_id"], :name => "index_products_on_user_id"

  create_table "units", :force => true do |t|
    t.string   "name"
    t.string   "shortName"
    t.boolean  "isDefault"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "units", ["user_id"], :name => "index_units_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "name"
    t.text     "about"
    t.string   "www"
    t.boolean  "isActive",                   :default => false, :null => false
    t.boolean  "agreementElectronicInvoice"
    t.boolean  "agreementProcessing"
    t.binary   "headerPicture"
    t.text     "headerText"
    t.text     "footerText"
    t.integer  "location_id"
    t.boolean  "partialInventory"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.string   "remember_token"
    t.boolean  "admin",                      :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["location_id"], :name => "index_users_on_location_id"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
