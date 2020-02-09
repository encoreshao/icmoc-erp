# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id              :integer          not null, primary key
#  name            :string
#  model           :string
#  brand_id        :integer
#  product_unit_id :integer
#  is_active       :boolean          default("false")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Product < ApplicationRecord
  include CommonScope

  validates :model, :name, presence: true, uniqueness: true

  belongs_to :brand
  belongs_to :product_unit
end
