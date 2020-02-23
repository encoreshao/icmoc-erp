# frozen_string_literal: true

module PermissionsHelper
  def allow_view_dashboard?
    allow_permissions [:user_dashboard]
  end

  def allow_manage_brands_products?
    allow_permissions %i[manage_brands manage_products]
  end

  def allow_manage_companies_projects_sales?
    allow_permissions %i[manage_companies manage_projects manage_sales]
  end

  def allow_mange_users_roles?
    allow_permissions %i[manage_users manage_roles]
  end

  def allow_manage_inventory_management?
    allow_permissions %i[manage_purchases manage_suppliers manage_repertories manage_deliveries manage_storages]
  end

  def allow_manage_finances_and_reports?
    allow_permissions %i[manage_finances manage_reports]
  end

  def allow_manage_reimbursements?
    allow_permissions %i[manage_reimbursements search_reimbursements]
  end

  def allow_manage_regions?
    allow_permissions %i[manage_provinces manage_cities manage_districts]
  end

  def allow_manage_settings_and_units_and_themes?
    allow_permissions %i[manage_settings manage_product_units manage_themes]
  end

  def allow_permissions(permissions)
    !(current_user.permissions & (permissions.is_a?(Array) ? permissions : [permissions])).blank?
  end
end
