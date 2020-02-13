# frozen_string_literal: true

# == Schema Information
#
# Table name: product_units
#
#  id          :bigint           not null, primary key
#  description :string
#  is_active   :boolean          default(TRUE)
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_product_units_on_name  (name)
#

class ProductUnit < ApplicationRecord
  include CommonScope

  validates :name, presence: true, uniqueness: true

  scope :active, -> { where(is_active: true) }

  def self.active_units
    active.select('id, name').map { |e| [e.name, e.id] }
  end
end
