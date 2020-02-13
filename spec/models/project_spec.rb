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

require 'rails_helper'

RSpec.describe Project, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
