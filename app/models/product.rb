# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id              :bigint           not null, primary key
#  is_active       :boolean          default(FALSE)
#  model           :string
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  brand_id        :bigint
#  product_unit_id :bigint
#
# Indexes
#
#  index_products_on_brand_id         (brand_id)
#  index_products_on_name             (name)
#  index_products_on_product_unit_id  (product_unit_id)
#

class Product < ApplicationRecord
  include CommonScope

  validates :model, :name, presence: true, uniqueness: true

  belongs_to :brand
  belongs_to :product_unit
end
