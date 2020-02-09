# frozen_string_literal: true

# == Schema Information
#
# Table name: role_permissions
#
#  id            :integer          not null, primary key
#  role_id       :integer
#  permission_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe RolePermission, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
