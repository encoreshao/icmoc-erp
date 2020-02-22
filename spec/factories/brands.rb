# frozen_string_literal: true

# == Schema Information
#
# Table name: brands
#
#  id          :bigint           not null, primary key
#  description :string
#  is_active   :boolean          default(FALSE)
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_brands_on_name  (name)
#

FactoryBot.define do
  factory :brand do
    sequence(:name) { |n| "Brand Name #{n}" }
  end
end
