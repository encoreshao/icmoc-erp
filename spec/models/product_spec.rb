# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id              :integer          not null, primary key
#  name            :string
#  model           :string
#  brand_id        :integer
#  product_unit_id :integer
#  is_active       :boolean          default("false")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe Product, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
