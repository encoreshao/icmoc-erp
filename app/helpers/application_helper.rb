# frozen_string_literal: true

module ApplicationHelper
  include Erp::I18n

  def breadcrumb_title(name)
    return t('menu.dashboard') if action_name == 'home'

    t("menu.#{name}")
  end

  # Return true if user is authorized for controller/action, otherwise false
  def authorize_for(controller, action)
    current_user.allowed_to?({ controller: controller, action: action }, @project)
  end

  def check_all_links(_form_name)
    link_to(
      el(:button_check_all),
      'javascript:void(0);',
      onclick: "checkAll('permissions', true); return false;",
      class: 'btn btn-primary'
    ) + ' '.html_safe +
      link_to(
        el(:button_uncheck_all),
        'javascript:void(0);',
        onclick: "checkAll('permissions', false); return false;",
        class: 'btn btn-warning'
      )
  end
end
