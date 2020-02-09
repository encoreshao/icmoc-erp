# frozen_string_literal: true

# == Schema Information
#
# Table name: reimbursements
#
#  id             :integer          not null, primary key
#  project_id     :integer
#  user_id        :integer
#  state          :string
#  episodes_count :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Reimbursement, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
