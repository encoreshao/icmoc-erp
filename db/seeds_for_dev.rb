# frozen_string_literal: true

p '> import mandatory seed...'
require Rails.root.join('db', 'seeds_mandatory')

p '> create Brand...'
Brand.delete_all
%w[西门子 施奈德].each do |name|
  Brand.create(name: name)
end

phone_prefixes = %w[152 139 138 150 151 137 136]

p '> Create users...'
(0..20).each do |i|
  name = (i == 0 ? 'Admin' : Faker::Name.name)

  user = User.new(
    email: "user#{i}@#{APP_CONFIG['domain']}",
    password: 'auto-123',
    subject: :employee
  )
  user.admin = (name == 'Admin')
  user.skip_confirmation!
  user.role_ids = [Role.all.sample.id]
  user.detail_attributes = {
    name: name,
    mobile_phone: phone_prefixes.sample + rand.to_s[4..11],
    age: rand(20..29),
    country: '中国'
  }
  user.save!
end

p '> create companies...'
%w[上海ABB工程有限公司 上海因特威工程有限公司].each do |name|
  Company.create(name: name)
end
