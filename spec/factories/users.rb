# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "admin-#{n.to_s.rjust(3, '0')}@icmoc.com" }
    password { 'icmoc-2020-2020' }
    password_confirmation { 'icmoc-2020-2020' }
    admin   { false }
    subject { :employee }
    after(:build, &:skip_confirmation!)
  end
end
