# frozen_string_literal: true

p '> import mandatory seed...'
require Rails.root.join('db', 'seeds_mandatory')

p '> create Brand...'
Brand.delete_all
%w[西门子 施奈德].each do |name|
  Brand.create(name: name)
end

phone_prefixes = %w[152 139 138 150 151 137 136 159]

p '> Create users...'
admin_role = Role.order('id ASC').first
(0..rand(10..15)).each do |i|
  name = (i == 0 ? 'Admin' : Faker::Name.name)

  user = User.new(
    email: "user#{i}@#{APP_CONFIG['domain']}",
    password: 'auto-123',
    subject: :employee
  )
  user.skip_confirmation!
  user.role_ids = [i == 0 ? admin_role.id : Role.where('id <> ?', admin_role).sample.id]
  user.detail_attributes = {
    name: name,
    mobile_phone: phone_prefixes.sample + rand.to_s[4..11],
    age: rand(20..29),
    country: '中国',
    theme: Theme.random_theme,
    locale: %i[en zh].sample
  }
  user.save!
end

p '> create companies...'
file_path = Rails.root.join('spec', 'factories', 'companies', 'companies.yaml')
YAML.safe_load(File.read(file_path)).each_value do |option|
  Company.create(option)
end
