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

class Episode < ApplicationRecord
  extend Enumerize

  validates :activity_date, :usage, :amount, presence: true

  belongs_to :reimbursement, counter_cache: true

  enumerize :usage, in: %i[meals accommodations materials taxi other], scopes: true, methods: true
end
