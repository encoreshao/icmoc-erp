# frozen_string_literal: true

Faker::Config.locale = 'zh-CN'

p '> create Role...'
Role.delete_all
%w[系统管理员 总经理 总经理助理 项目经理 财务 工程师 销售 采购 仓库 商务].each_with_index do |name, index|
  Role.create(
    name: name,
    position: (index + 1),
    permissions: Erp::AccessControl.public_permissions.collect(&:name)
  )
end

p '> create Product unit...'
ProductUnit.delete_all
%w[米 厘米 毫米 只 套 箱 支 个 包 台 盒 卷].each do |name|
  ProductUnit.create(name: name)
end

p '> create Setting...'
Setting.delete_all
Setting.create(depot_alarm_value: 200, project_payment_mode: 'mode1', purchase_payment_mode: 'mode1')
