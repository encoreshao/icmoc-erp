# frozen_string_literal: true

# == Schema Information
#
# Table name: user_roles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  role_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserRole < ActiveRecord::Base
  belongs_to :role
  belongs_to :user
end
