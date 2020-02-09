# frozen_string_literal: true

# == Schema Information
#
# Table name: product_units
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  is_active   :boolean          default("true")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ProductUnit < ActiveRecord::Base
  include CommonScope

  validates :name, presence: true, uniqueness: true

  scope :active, -> { where(is_active: true) }

  def self.active_units
    active.select('id, name').map { |e| [e.name, e.id] }
  end
end
