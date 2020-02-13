# frozen_string_literal: true

# == Schema Information
#
# Table name: provinces
#
#  id           :bigint           not null, primary key
#  cities_count :integer          default(0)
#  code         :integer
#  name         :string
#  name_abbr    :string
#  name_en      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_provinces_on_name  (name)
#

class Province < ApplicationRecord
  include CommonScope

  # Validations
  validates :code, presence: true
  validates :name, presence: true, uniqueness: {
    case_sensitive: false
  }

  # Relationships
  has_many :cities, dependent: :destroy
  has_many :districts, through: :cities

  class << self
    def options
      select('id, name').map { |e| [e.name, e.id] }
    end
  end
end
