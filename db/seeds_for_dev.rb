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
[
  {
    name: '上海ABB工程有限公司',
    address: '上海市浦东新区康新公路4528号',
    telephone: '021 6105 6677',
    postcode: '201319',
    contact_person: '李刚',
    website: 'https://new.abb.com',
    industry: '自动化',
    province: Province.find_by(name_en: 'shanghai'),
    description: '上海ABB工程有限公司是ABB的重要本地企业之一，是ABB在华工业机器人及系统业务（离散自动化与运动控制）、仪器仪表（过程自动化）、变电站自动化系统（电力系统）和集成分析系统 （过程自动化）的主要生产工程基地。上海ABB工程有限公司自2008年起连续三年跻身“中国工业电气100强企业”之列。'
  },
  {
    name: '上海贝特威自动化科技有限公司',
    address: '上海市闵行区沪闵路3088号北门B幢（沪闵路瓶北路交叉口）',
    website: 'https://www.shbetterway.com/',
    telephone: '86-21-64139268',
    fax: '86-21-64139208',
    contact_email: 'info@shbetterway.com',
    industry: '自动化',
    province: Province.find_by(name_en: 'shanghai'),
    description: '贝特威自动化，2004年成立于中国上海，是一家集研发、设计、制造、服务于一体，致力于为汽车、汽车零部件、电子、电器等行业提供专业视觉检测设备和解决方案的公司。贝特威自动化以专业的技术、完善的管理，周到的服务为基础'
  }
].each do |option|
  Company.create(option)
end
