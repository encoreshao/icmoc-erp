# frozen_string_literal: true

# == Schema Information
#
# Table name: episodes
#
#  id               :integer          not null, primary key
#  reimbursement_id :integer
#  activity_date    :date
#  usage            :string
#  amount           :float
#  description      :text
#  count            :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe Episode, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
