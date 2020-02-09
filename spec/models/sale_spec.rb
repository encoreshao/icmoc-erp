# frozen_string_literal: true

# == Schema Information
#
# Table name: sales
#
#  id                 :integer          not null, primary key
#  company_id         :integer
#  contact_no         :string
#  name               :string
#  payment_mode       :string
#  money              :float
#  freight_charge     :float
#  tax                :string
#  type_name          :string
#  state              :string
#  order_type         :string
#  order_no           :string
#  delivery_time      :date
#  delivery_place     :string
#  delivery_content   :text
#  number             :integer
#  unit               :string
#  description        :text
#  owner_id           :integer
#  created_by         :integer
#  created_date       :datetime
#  last_modified_by   :integer
#  last_modified_date :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe Sale, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
