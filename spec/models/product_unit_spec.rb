# frozen_string_literal: true

# == Schema Information
#
# Table name: product_units
#
#  id          :bigint           not null, primary key
#  description :string
#  is_active   :boolean          default(TRUE)
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_product_units_on_name  (name)
#

require 'rails_helper'

RSpec.describe ProductUnit, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
