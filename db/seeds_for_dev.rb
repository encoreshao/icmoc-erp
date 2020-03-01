# frozen_string_literal: true

p '> import mandatory seed...'
require Rails.root.join('db', 'seeds_mandatory')

p '> create Brand...'
Brand.delete_all
%w[西门子 施奈德].each do |name|
  Brand.create(name: name)
end

p '> Create users...'
admin_role = Role.order('id ASC').first
def detail_attributes(name)
  {
    name: name,
    mobile_phone: %w[152 139 138 150 151 137 136 159].sample + rand.to_s[4..11],
    age: rand(20..29),
    country: '中国',
    theme: Theme.random_theme,
    locale: %i[en zh].sample
  }
end

[
  {
    password: 'admin',
    subject: :employee,
    role_ids: admin_role.id,
    detail_attributes: detail_attributes('Admin')
  },
  {
    password: 'user',
    subject: :employee,
    role_ids: Role.where('id <> ?', admin_role).sample.id,
    detail_attributes: detail_attributes('User')
  }
].each do |option|
  user = User.new(option)
  user.skip_confirmation!
  user.save!
end

p '> create companies...'
file_path = Rails.root.join('spec', 'factories', 'companies', 'companies.yaml')
YAML.safe_load(File.read(file_path)).each_value do |option|
  Company.create(option)
end
