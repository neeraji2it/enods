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

ActiveRecord::Schema.define(:version => 20140304045301) do

  create_table "banner_images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.text     "image_description"
  end

  create_table "billing_shipping_addresses", :force => true do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.integer  "order_id"
    t.string   "billling_house_no"
    t.string   "shipping_house_no"
    t.string   "billing_street"
    t.string   "shipping_street"
    t.string   "billing_city"
    t.string   "shipping_city"
    t.string   "billing_zip"
    t.string   "shipping_zip"
    t.string   "billing_country"
    t.string   "shipping_country"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "carts", :force => true do |t|
    t.datetime "purchased_at"
    t.integer  "product_id"
    t.string   "paypal_express_token"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "parent_id"
  end

  create_table "causes", :force => true do |t|
    t.string   "title"
    t.integer  "product_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.text     "description"
  end

  create_table "colors", :force => true do |t|
    t.integer  "product_id"
    t.string   "product_color"
    t.integer  "product_qty",       :default => 0
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "product_attribute"
    t.string   "size"
    t.string   "buyer_type"
  end

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "contact_shop_owners", :force => true do |t|
    t.integer  "user_id"
    t.integer  "receiver_id"
    t.string   "subject"
    t.text     "message"
    t.string   "attach_file_name"
    t.string   "attach_content_type"
    t.integer  "attach_file_size"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.string   "option"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "email_alerts", :force => true do |t|
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "favourites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.boolean  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "images", :force => true do |t|
    t.integer  "product_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "invitations", :force => true do |t|
    t.string   "email"
    t.integer  "sender_id"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "line_items", :force => true do |t|
    t.decimal  "unit_price", :precision => 10, :scale => 0
    t.integer  "product_id"
    t.integer  "cart_id"
    t.integer  "quantity"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "user_id"
  end

  create_table "orders", :force => true do |t|
    t.integer  "cart_id"
    t.integer  "user_id"
    t.string   "paykey"
    t.text     "details"
    t.string   "status"
    t.string   "net_payment"
    t.string   "admin_payment"
    t.string   "non_profit_payment"
    t.datetime "cancel_date"
    t.string   "payment_type"
    t.datetime "confirm_date"
    t.integer  "product_id"
    t.integer  "line_item_id"
    t.integer  "receiver_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "shipping"
    t.string   "color"
    t.string   "buyer_type"
    t.string   "size"
    t.string   "cause"
  end

  create_table "products", :force => true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "title"
    t.text     "description"
    t.string   "price"
    t.integer  "product_count",                                        :default => 0
    t.string   "status"
    t.decimal  "qty",                   :precision => 10, :scale => 0, :default => 0
    t.string   "color"
    t.decimal  "qty_sold",              :precision => 10, :scale => 0, :default => 0
    t.string   "non_profit_email"
    t.string   "fair_trade"
    t.integer  "cause_id"
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.integer  "non_profit_percentage"
    t.string   "non_profit_cause"
    t.boolean  "agree_terms"
    t.integer  "discount"
    t.string   "sell_name"
    t.text     "shipping"
    t.text     "terms_and_conditions"
    t.string   "cause_sub_category"
  end

  create_table "reviews", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.string   "name"
    t.text     "message"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "rating"
  end

  create_table "share_products", :force => true do |t|
    t.integer  "product_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.text     "details"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "shipping_products", :force => true do |t|
    t.integer  "product_id"
    t.string   "country"
    t.string   "cost"
    t.string   "location"
    t.string   "item_cost"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                    :default => "", :null => false
    t.string   "encrypted_password",       :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",          :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "gender"
    t.boolean  "agree_terms"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.text     "details"
    t.string   "role"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.string   "image"
    t.string   "business_name"
    t.string   "website_url"
    t.text     "business_address"
    t.string   "city"
    t.string   "zip"
    t.string   "country"
    t.string   "state"
    t.string   "phone"
    t.string   "paypal_id"
    t.date     "date_of_birth"
    t.text     "other_info"
    t.string   "active"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "store_image_file_name"
    t.string   "store_image_content_type"
    t.integer  "store_image_file_size"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
