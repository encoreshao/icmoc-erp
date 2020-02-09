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

class Episode < ActiveRecord::Base
  extend Enumerize

  validates :activity_date, :usage, :amount, presence: true

  belongs_to :reimbursement, counter_cache: true

  enumerize :usage, in: %i[meals accommodations materials taxi other], scopes: true, methods: true
end
