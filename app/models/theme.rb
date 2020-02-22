# frozen_string_literal: true

# == Schema Information
#
# Table name: themes
#
#  id         :bigint           not null, primary key
#  appearance :string
#  image      :string
#  name       :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Theme < ApplicationRecord
  extend Enumerize

  # Validations
  validates :name, presence: true

  enumerize :appearance, in: %i[default light brown blue dark], scopes: true, default: :default

  mount_uploader :image, ThemeImageUploader

  has_many :user_details, dependent: :nullify
  has_many :users, through: :user_dtails

  scope :sorting, -> { order(position: :asc) }

  class << self
    def default_image
      default_theme.image
    end

    def default_theme
      find_by(name: 'Atmosphere')
    end

    def random_theme
      order(Arel.sql('RANDOM()')).first
    end

    def options
      select('id, name, appearance').map { |e| [[e.appearance_text, e.name].join(' - '), e.id] }
    end
  end
end
