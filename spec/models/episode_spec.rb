# frozen_string_literal: true

# == Schema Information
#
# Table name: episodes
#
#  id               :bigint           not null, primary key
#  activity_date    :date
#  amount           :float
#  count            :integer
#  description      :text
#  usage            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  reimbursement_id :bigint
#
# Indexes
#
#  index_episodes_on_reimbursement_id  (reimbursement_id)
#

require 'rails_helper'

RSpec.describe Episode, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
