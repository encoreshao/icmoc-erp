# frozen_string_literal: true

# == Schema Information
#
# Table name: districts
#
#  id         :bigint           not null, primary key
#  code       :integer
#  name       :string
#  name_abbr  :string
#  name_en    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  city_id    :integer
#
# Indexes
#
#  index_districts_on_city_id  (city_id)
#  index_districts_on_name     (name)
#

class District < ApplicationRecord
  include CommonScope

  # Validations
  validates :name, presence: true, uniqueness: {
    case_sensitive: false,
    scope: [:city_id]
  }

  # Relationships
  belongs_to :city, counter_cache: true
  delegate :name, to: :city, prefix: true

  # Filters
  scope :for_city, ->(city_id) { where(city_id: city_id) unless city_id.blank? }

  def province
    city&.province
  end

  def full_name
    [province&.name, city_name, name].compact.join(' - ')
  end

  def short_name
    @short_name ||= name.gsub(/区|县|市|自治县/, '')
  end

  def siblings
    @siblings ||= where(nil).for_city(city_id)
  end

  class << self
    def options
      select('id, name').map { |e| [e.name, e.id] }
    end
  end
end
