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
