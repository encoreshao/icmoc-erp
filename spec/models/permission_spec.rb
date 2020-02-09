# frozen_string_literal: true

# == Schema Information
#
# Table name: permissions
#
#  id          :integer          not null, primary key
#  name        :string
#  code        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Permission, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
