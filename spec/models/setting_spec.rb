# frozen_string_literal: true

# == Schema Information
#
# Table name: settings
#
#  id                    :integer          not null, primary key
#  depot_alarm_value     :integer
#  project_payment_mode  :string
#  purchase_payment_mode :string
#  created_by            :integer
#  created_date          :datetime
#  last_modified_by      :integer
#  last_modified_date    :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'rails_helper'

RSpec.describe Setting, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
