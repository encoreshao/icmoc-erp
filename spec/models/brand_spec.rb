# frozen_string_literal: true

# == Schema Information
#
# Table name: brands
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  is_active   :boolean          default("false")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Brand, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
