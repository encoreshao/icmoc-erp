# frozen_string_literal: true

# == Schema Information
#
# Table name: cities
#
#  id              :bigint           not null, primary key
#  code            :integer
#  districts_count :integer          default(0)
#  level           :integer
#  name            :string
#  name_abbr       :string
#  name_en         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  province_id     :integer
#
# Indexes
#
#  index_cities_on_name         (name)
#  index_cities_on_province_id  (province_id)
#

class City < ApplicationRecord
  include CommonScope

  # Validations
  validates :code, presence: true
  validates :name, presence: true, uniqueness: {
    case_sensitive: false,
    scope: [:province_id]
  }

  # Relationships
  belongs_to :province, counter_cache: true
  delegate :name, to: :province, prefix: true

  has_many :districts, dependent: :destroy

  # Fileters
  scope :for_province, ->(province_id) { where(province_id: province_id) }

  def full_name
    [province_name, name].compact.join(' - ')
  end

  def short_name
    @short_name ||= name.gsub(/市|自治州|地区|特别行政区/, '')
  end

  def siblings
    @siblings ||= where(nil).for_province(province_id)
  end

  class << self
    def options
      select('id, name').map { |e| [e.name, e.id] }
    end
  end
end
