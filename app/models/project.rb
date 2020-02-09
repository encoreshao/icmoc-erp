# frozen_string_literal: true

# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string
#  number     :string
#  pm_user_id :integer
#  budget     :float
#  sale_id    :integer
#  is_closed  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Project < ApplicationRecord
  validates :name, :sale_id, :number, presence: true
  validates :number, uniqueness: true

  belongs_to :sale
  belongs_to :manager, class_name: 'User', primary_key: 'id', foreign_key: 'pm_user_id'

  def self.numbers
    all.select('number').map { |e| [e.number, e.id] }
  end
end
