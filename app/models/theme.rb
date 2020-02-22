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

  enumerize :appearance, in: %i[light dark], scopes: true, default: :light

  mount_uploader :image, ThemeImageUploader

  has_many :user_details, dependent: :nullify
  has_many :users, through: :user_details

  scope :sorting, -> { order(position: :asc) }
end
