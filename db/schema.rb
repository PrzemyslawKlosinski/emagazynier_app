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

ActiveRecord::Schema.define(:version => 20130210041731) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.boolean  "isDefault"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categories", ["user_id"], :name => "index_categories_on_user_id"

  create_table "documents", :force => true do |t|
    t.boolean  "is_income"
    t.boolean  "is_outcome"
    t.boolean  "is_correct"
    t.integer  "status"
    t.string   "name"
    t.string   "title"
    t.datetime "document_date"
    t.decimal  "brutto_value"
    t.decimal  "netto_value"
    t.decimal  "brutto_netto"
    t.text     "description"
    t.string   "receipt"
    t.datetime "receipt_date"
    t.boolean  "blocked"
    t.integer  "document_correct_id"
    t.integer  "last_correct_id"
    t.integer  "user_id"
    t.integer  "firm_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.boolean  "is_local"
    t.string   "prefix"
  end

  add_index "documents", ["document_correct_id"], :name => "index_documents_on_document_correct_id"
  add_index "documents", ["firm_id"], :name => "index_documents_on_firm_id"
  add_index "documents", ["last_correct_id"], :name => "index_documents_on_last_correct_id"
  add_index "documents", ["user_id"], :name => "index_documents_on_user_id"

  create_table "firms", :force => true do |t|
    t.string   "name"
    t.string   "www"
    t.string   "email"
    t.integer  "current_address_id"
    t.integer  "user_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "firms", ["current_address_id"], :name => "index_firms_on_current_address_id"
  add_index "firms", ["user_id"], :name => "index_firms_on_user_id"

  create_table "locations", :force => true do |t|
    t.string   "zip_code"
    t.string   "city"
    t.string   "address"
    t.string   "phone"
    t.integer  "firm_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "locations", ["firm_id"], :name => "index_locations_on_firm_id"

  create_table "product_prices", :force => true do |t|
    t.decimal  "nettoPurchasePrice",  :default => 0.0
    t.decimal  "bruttoPurchasePrice", :default => 0.0
    t.decimal  "nettoSalesPrice",     :default => 0.0
    t.decimal  "bruttoSalesPrice",    :default => 0.0
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "calculateByPurchase", :default => true, :null => false
    t.integer  "product_id"
  end

  create_table "products", :force => true do |t|
    t.decimal  "summaryQuantityPurchase", :default => 0.0
    t.decimal  "summaryQuantitySales",    :default => 0.0
    t.string   "nameOryginal"
    t.string   "name"
    t.decimal  "quantity",                :default => 0.0
    t.decimal  "reservedQuantity",        :default => 0.0
    t.decimal  "quantityMinimum",         :default => 0.0
    t.decimal  "quantityMaximum",         :default => 0.0
    t.text     "warningNote"
    t.boolean  "isWarningShow"
    t.text     "description"
    t.binary   "picture"
    t.boolean  "blocked"
    t.integer  "user_id"
    t.integer  "category_id"
    t.integer  "productPrice_id"
    t.decimal  "defaultVat",              :default => 23.0
    t.boolean  "actualPriceOnPurchase",   :default => true,  :null => false
    t.string   "manufacturer"
    t.string   "color"
    t.string   "intended"
    t.string   "location"
    t.string   "size"
    t.string   "shape"
    t.integer  "unit_id"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.boolean  "is_public",               :default => false
    t.integer  "discount",                :default => 0
    t.string   "prefix"
    t.integer  "number"
  end

  add_index "products", ["category_id"], :name => "index_products_on_category_id"
  add_index "products", ["productPrice_id"], :name => "index_products_on_productPrice_id"
  add_index "products", ["unit_id"], :name => "index_products_on_unit_id"
  add_index "products", ["user_id", "created_at"], :name => "index_products_on_user_id_and_created_at"
  add_index "products", ["user_id"], :name => "index_products_on_user_id"

  create_table "quantities", :force => true do |t|
    t.decimal  "amount",             :default => 0.0, :null => false
    t.decimal  "netto_price",        :default => 0.0
    t.decimal  "brutto_price",       :default => 0.0
    t.integer  "product_id"
    t.integer  "document_id"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "discount",           :default => 0
    t.decimal  "unsold",             :default => 0.0, :null => false
    t.decimal  "netto_sales_price",  :default => 0.0
    t.decimal  "brutto_sales_price", :default => 0.0
  end

  add_index "quantities", ["document_id"], :name => "index_quantities_on_document_id"
  add_index "quantities", ["product_id"], :name => "index_quantities_on_product_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

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
