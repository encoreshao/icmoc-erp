# frozen_string_literal: true

# == Schema Information
#
# Table name: reimbursements
#
#  id             :bigint           not null, primary key
#  episodes_count :integer
#  state          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  project_id     :bigint
#  user_id        :bigint
#
# Indexes
#
#  index_reimbursements_on_project_id  (project_id)
#  index_reimbursements_on_user_id     (user_id)
#

require 'rails_helper'

RSpec.describe Reimbursement, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
