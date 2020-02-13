# frozen_string_literal: true

# == Schema Information
#
# Table name: projects
#
#  id         :bigint           not null, primary key
#  budget     :float
#  is_closed  :boolean
#  name       :string
#  number     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  pm_user_id :integer
#  sale_id    :bigint
#
# Indexes
#
#  index_projects_on_name        (name)
#  index_projects_on_number      (number)
#  index_projects_on_pm_user_id  (pm_user_id)
#  index_projects_on_sale_id     (sale_id)
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
