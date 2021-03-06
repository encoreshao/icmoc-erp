# frozen_string_literal: true

# == Schema Information
#
# Table name: settings
#
#  id                    :bigint           not null, primary key
#  created_by            :integer
#  created_date          :datetime
#  depot_alarm_value     :integer
#  last_modified_by      :integer
#  last_modified_date    :datetime
#  project_payment_mode  :string
#  purchase_payment_mode :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Setting < ApplicationRecord
  extend Enumerize

  belongs_to :modified, class_name: 'User', primary_key: 'id', foreign_key: 'last_modified_by'

  enumerize :project_payment_mode, in: %i[mode1 mode2 mode3 mode4], scopes: true, methods: true
  enumerize :purchase_payment_mode, in: %i[mode1 mode2 mode3 mode4], scopes: true, methods: true

  before_create :setup_created_date!
  before_update :setup_updated_date!

  private

  def setup_created_date!
    created_date = Time.now
  end

  def setup_updated_date!
    last_modified_date = Time.now
  end
end
