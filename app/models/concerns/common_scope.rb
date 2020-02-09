# frozen_string_literal: true

module CommonScope
  extend ActiveSupport::Concern

  included do
    scope :with_name, ->(name) { name.blank? ? nil : where('name LIKE ?', "%#{name}%") }
    scope :with_title, ->(name) { name.blank? ? nil : where('title LIKE ?', "%#{name}%") }
  end
end
