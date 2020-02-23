# frozen_string_literal: true

p '> create Role...'
Role.delete_all
eac = Erp::AccessControl
%w[系统管理员 总经理 总经理助理 项目经理 财务 工程师 销售 采购 仓库 商务].each_with_index do |name, index|
  role = Role.find_or_create_by(name: name)
  permissions = case index
                when 0
                  eac.permissions
                when 1..3
                  eac.permissions
                when 4
                  eac.finances_permissions
                else
                  eac.public_permissions
                end
  role.update(position: (index + 1), permissions: permissions.collect(&:name))
end

p '> create Product unit...'
ProductUnit.delete_all
%w[米 厘米 毫米 只 套 箱 支 个 包 台 盒 卷].each do |name|
  ProductUnit.create(name: name)
end

p '> create Setting...'
Setting.delete_all
Setting.create(depot_alarm_value: 200, project_payment_mode: 'mode1', purchase_payment_mode: 'mode1')
