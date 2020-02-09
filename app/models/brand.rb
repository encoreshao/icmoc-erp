# frozen_string_literal: true

# == Schema Information
#
# Table name: brands
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  is_active   :boolean          default("false")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Brand < ApplicationRecord
  include CommonScope

  validates :name, presence: true, uniqueness: true

  scope :active, -> { where(is_active: false) }

  class << self
    def options
      active.select('id, name').map { |e| [e.name, e.id] }
    end
  end
end
