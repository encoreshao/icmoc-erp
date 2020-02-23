# frozen_string_literal: true

require 'erp/i18n'
require 'erp/access_control'
require 'erp/version'
require 'erp/info'

# Permissions
Erp::AccessControl.map do |resources|
  resources.project_module :home do |map_resource|
    map_resource.permission :user_dashboard, { home: [:index] }, public: true, require: :loggedin
  end

  resources.project_module :users do |map_resource|
    map_resource.permission :manage_users,
                            { users: %i[index show create update destroy disable] },
                            require: :loggedin
    map_resource.permission :view_user, { users: [:show] }, require: :loggedin
    map_resource.permission :add_user, { users: %i[new create] }, require: :loggedin
    map_resource.permission :edit_user, { users: %i[edit update] }, require: :loggedin
    map_resource.permission :disable_user, { users: [:disable] }, require: :loggedin
    map_resource.permission :profile_user, { users: [:profile] }, public: true, require: :loggedin
  end

  resources.project_module :roles do |map_resource|
    map_resource.permission :manage_roles,
                            { roles: %i[index show create update destroy] },
                            require: :member
    map_resource.permission :view_role, { roles: [:show] }, read: true
    map_resource.permission :add_role, { roles: %i[new create] }, require: :loggedin
    map_resource.permission :edit_role, { roles: %i[edit update] }, require: :member
  end

  resources.project_module :projects do |map_resource|
    map_resource.permission :manage_projects,
                            { projects: %i[index new create edit update destroy] },
                            require: :project
    map_resource.permission :search_project, { search: :index }, read: true
    map_resource.permission :view_project, { projects: [:show] }, read: true
    map_resource.permission :add_project, { projects: %i[new create] }, require: :loggedin
    map_resource.permission :edit_project, { projects: %i[edit update] }, require: :member
    map_resource.permission :close_project, { projects: %i[close reopen] }, require: :member, read: true
  end

  resources.project_module :sales do |map_resource|
    map_resource.permission :manage_sales,
                            { sales: %i[index new create edit update destroy] },
                            require: :member
    map_resource.permission :search_sale, { search: :index }, read: true
    map_resource.permission :add_sale, { sales: %i[new create] }, require: :loggedin
    map_resource.permission :edit_sale, { sales: %i[edit update] }, require: :member
    map_resource.permission :delete_sale, { sales: [:destroy] }, require: :member
    map_resource.permission :view_sale, { sales: [:show] }, read: true
  end

  resources.project_module :brands do |map_resource|
    map_resource.permission :manage_brands,
                            { brands: %i[index new create edit update destroy] },
                            require: :member
    map_resource.permission :search_brands, { search: :index }, read: true
    map_resource.permission :view_brand, { brands: [:show] }, read: true
    map_resource.permission :add_brand, { brands: %i[new create] }, require: :loggedin
    map_resource.permission :edit_brand, { brands: %i[edit update] }, require: :member
    map_resource.permission :delete_brand, { brands: [:destroy] }, require: :member
  end

  resources.project_module :companies do |map_resource|
    map_resource.permission :manage_companies,
                            { companies: %i[index new create edit update destroy] },
                            require: :project
    map_resource.permission :search_companies, { search: :index }, read: true
    map_resource.permission :view_company, { companies: [:show] }, read: true
    map_resource.permission :add_company, { companies: %i[new create] }, require: :loggedin
    map_resource.permission :edit_company, { companies: %i[edit update] }, require: :member
    map_resource.permission :delete_company, { companies: [:destroy] }, require: :member
  end

  resources.project_module :productunits do |map_resource|
    map_resource.permission :manage_productunits,
                            { product_units: %i[index new create edit update destroy] },
                            require: :member
    map_resource.permission :view_productunit, { product_units: [:show] }, require: :loggedin
    map_resource.permission :add_productunit, { product_units: %i[new create] }, require: :loggedin
    map_resource.permission :edit_productunit, { product_units: %i[edit update] }, require: :member
    map_resource.permission :delete_productunit, { product_units: [:destroy] }, require: :member
  end

  resources.project_module :products do |map_resource|
    map_resource.permission :manage_products,
                            { products: %i[new create edit update destroy] },
                            require: :member
    map_resource.permission :search_products, { search: :index }, read: true
    map_resource.permission :view_product, { products: [:show] }, read: true
    map_resource.permission :add_product, { products: %i[new create] }, require: :loggedin
    map_resource.permission :edit_product, { products: %i[edit update] }, require: :member
    map_resource.permission :delete_product, { products: [:destroy] }, require: :member
  end

  resources.project_module :reimbursements do |map_resource|
    map_resource.permission :admin_reimbursements,
                            { reimbursements: %i[all confirm pay] },
                            require: :finance
    map_resource.permission :manage_reimbursements,
                            { reimbursements: %i[index new create edit update destroy] },
                            require: :loggedin
    map_resource.permission :search_reimbursements, { search: :index }, public: true, require: :loggedin
    map_resource.permission :view_reimbursement, { reimbursements: [:show] }, public: true, require: :loggedin
    map_resource.permission :add_reimbursement, { reimbursements: %i[new create] }, public: true, require: :loggedin
    map_resource.permission :edit_reimbursement, { reimbursements: %i[edit update] }, public: true, require: :loggedin
    map_resource.permission :delete_reimbursement, { reimbursements: [:destroy] }, public: true, require: :loggedin
  end

  # Basic setting module
  resources.project_module :settings do |map_resource|
    map_resource.permission :manage_settings,
                            { settings: %i[index new create edit update destroy] },
                            require: :member
    map_resource.permission :view_setting, { settings: [:show] }, read: true, require: :loggedin
    map_resource.permission :add_setting, { settings: %i[new create] }, require: :loggedin
    map_resource.permission :edit_setting, { settings: %i[edit update] }, require: :member
    map_resource.permission :delete_setting, { settings: [:destroy] }, require: :member
  end

  resources.project_module :provinces do |map_resource|
    map_resource.permission :manage_provinces,
                            { provinces: %i[index new create edit update destroy] },
                            require: :member
    map_resource.permission :view_province, { provinces: [:show] }, require: :member
    map_resource.permission :add_province, { provinces: %i[new create] }, require: :member
    map_resource.permission :edit_province, { provinces: %i[edit update] }, require: :member
    map_resource.permission :delete_province, { provinces: [:destroy] }, require: :member
  end

  resources.project_module :cities do |map_resource|
    map_resource.permission :manage_cities,
                            { cities: %i[index new create edit update destroy] },
                            require: :member
    map_resource.permission :view_city, { cities: [:show] }, require: :member
    map_resource.permission :add_city, { cities: %i[new create] }, require: :member
    map_resource.permission :edit_city, { cities: %i[edit update] }, require: :member
    map_resource.permission :delete_city, { cities: [:destroy] }, require: :member
  end

  resources.project_module :districts do |map_resource|
    map_resource.permission :manage_districts,
                            { districts: %i[index new create edit update destroy] },
                            require: :member
    map_resource.permission :view_city, { districts: [:show] }, require: :member
    map_resource.permission :add_city, { districts: %i[new create] }, require: :member
    map_resource.permission :edit_city, { districts: %i[edit update] }, require: :member
    map_resource.permission :delete_city, { districts: [:destroy] }, require: :member
  end

  resources.project_module :themes do |map_resource|
    map_resource.permission :manage_themes,
                            { themes: %i[index new create edit update destroy] },
                            require: :member
    map_resource.permission :view_theme, { themes: [:show] }, require: :member
    map_resource.permission :add_theme, { themes: %i[new create] }, require: :member
    map_resource.permission :edit_theme, { themes: %i[edit update] }, require: :member
    map_resource.permission :delete_theme, { themes: [:destroy] }, require: :member
  end
end
