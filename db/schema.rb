# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_200_209_130_238) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'brands', force: :cascade do |t|
    t.string 'name'
    t.string 'description'
    t.boolean 'is_active', default: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_brands_on_name'
  end

  create_table 'cities', force: :cascade do |t|
    t.string 'name'
    t.integer 'code'
    t.integer 'province_id'
    t.integer 'level'
    t.string 'name_en'
    t.string 'name_abbr'
    t.integer 'districts_count', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_cities_on_name'
    t.index ['province_id'], name: 'index_cities_on_province_id'
  end

  create_table 'companies', force: :cascade do |t|
    t.string 'name'
    t.string 'logo'
    t.integer 'province_id'
    t.integer 'city_id'
    t.integer 'district_id'
    t.string 'address'
    t.string 'contact_person'
    t.string 'contact_email'
    t.string 'telephone'
    t.string 'website'
    t.string 'fax'
    t.string 'postcode'
    t.string 'industry'
    t.string 'nature_of_business'
    t.string 'tax_no'
    t.string 'legal_person'
    t.string 'bank_address'
    t.string 'bank_account'
    t.text 'overview'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['city_id'], name: 'index_companies_on_city_id'
    t.index ['district_id'], name: 'index_companies_on_district_id'
    t.index ['name'], name: 'index_companies_on_name'
    t.index ['province_id'], name: 'index_companies_on_province_id'
  end

  create_table 'districts', force: :cascade do |t|
    t.string 'name'
    t.integer 'city_id'
    t.integer 'code'
    t.string 'name_en'
    t.string 'name_abbr'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['city_id'], name: 'index_districts_on_city_id'
    t.index ['name'], name: 'index_districts_on_name'
  end

  create_table 'episodes', force: :cascade do |t|
    t.bigint 'reimbursement_id'
    t.date 'activity_date'
    t.string 'usage'
    t.float 'amount'
    t.text 'description'
    t.integer 'count'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['reimbursement_id'], name: 'index_episodes_on_reimbursement_id'
  end

  create_table 'product_units', force: :cascade do |t|
    t.string 'name'
    t.string 'description'
    t.boolean 'is_active', default: true
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_product_units_on_name'
  end

  create_table 'products', force: :cascade do |t|
    t.string 'name'
    t.string 'model'
    t.bigint 'brand_id'
    t.bigint 'product_unit_id'
    t.boolean 'is_active', default: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['brand_id'], name: 'index_products_on_brand_id'
    t.index ['name'], name: 'index_products_on_name'
    t.index ['product_unit_id'], name: 'index_products_on_product_unit_id'
  end

  create_table 'projects', force: :cascade do |t|
    t.string 'name'
    t.string 'number'
    t.integer 'pm_user_id'
    t.float 'budget'
    t.bigint 'sale_id'
    t.boolean 'is_closed'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_projects_on_name'
    t.index ['number'], name: 'index_projects_on_number'
    t.index ['pm_user_id'], name: 'index_projects_on_pm_user_id'
    t.index ['sale_id'], name: 'index_projects_on_sale_id'
  end

  create_table 'provinces', force: :cascade do |t|
    t.string 'name'
    t.integer 'code'
    t.string 'name_en'
    t.string 'name_abbr'
    t.integer 'cities_count', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_provinces_on_name'
  end

  create_table 'reimbursements', force: :cascade do |t|
    t.bigint 'project_id'
    t.bigint 'user_id'
    t.string 'state'
    t.integer 'episodes_count'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['project_id'], name: 'index_reimbursements_on_project_id'
    t.index ['user_id'], name: 'index_reimbursements_on_user_id'
  end

  create_table 'roles', force: :cascade do |t|
    t.string 'name'
    t.integer 'position'
    t.boolean 'assignable'
    t.integer 'builtin', default: 0, null: false
    t.text 'permissions'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_roles_on_name'
  end

  create_table 'sales', force: :cascade do |t|
    t.integer 'company_id'
    t.string 'contact_no'
    t.string 'name'
    t.string 'payment_mode'
    t.float 'money'
    t.float 'freight_charge'
    t.string 'tax'
    t.string 'type_name'
    t.string 'state'
    t.string 'order_type'
    t.string 'order_no'
    t.date 'delivery_time'
    t.string 'delivery_place'
    t.text 'delivery_content'
    t.integer 'number'
    t.string 'unit'
    t.text 'description'
    t.integer 'owner_id'
    t.integer 'created_by'
    t.datetime 'created_date'
    t.integer 'last_modified_by'
    t.datetime 'last_modified_date'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['company_id'], name: 'index_sales_on_company_id'
    t.index ['contact_no'], name: 'index_sales_on_contact_no'
    t.index ['order_no'], name: 'index_sales_on_order_no'
    t.index ['owner_id'], name: 'index_sales_on_owner_id'
  end

  create_table 'settings', force: :cascade do |t|
    t.integer 'depot_alarm_value'
    t.string 'project_payment_mode'
    t.string 'purchase_payment_mode'
    t.integer 'created_by'
    t.datetime 'created_date'
    t.integer 'last_modified_by'
    t.datetime 'last_modified_date'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'user_details', force: :cascade do |t|
    t.string 'name'
    t.string 'avatar'
    t.string 'address'
    t.string 'mobile_phone'
    t.string 'gender'
    t.string 'position'
    t.integer 'age'
    t.date 'birthday'
    t.string 'marriage'
    t.date 'hiredate'
    t.string 'country'
    t.string 'birthplace'
    t.string 'nationality'
    t.string 'id_card_no'
    t.bigint 'user_id'
    t.string 'contact_person'
    t.string 'contact_phone'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_user_details_on_user_id'
  end

  create_table 'user_roles', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'role_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['role_id'], name: 'index_user_roles_on_role_id'
    t.index ['user_id'], name: 'index_user_roles_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.inet 'current_sign_in_ip'
    t.inet 'last_sign_in_ip'
    t.string 'admin'
    t.string 'subject'
    t.boolean 'active', default: false
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email'
    t.integer 'failed_attempts', default: 0, null: false
    t.string 'unlock_token'
    t.datetime 'locked_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    t.index ['unlock_token'], name: 'index_users_on_unlock_token', unique: true
  end
end
