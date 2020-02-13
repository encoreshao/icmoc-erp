# frozen_string_literal: true

# == Schema Information
#
# Table name: sales
#
#  id                 :bigint           not null, primary key
#  contact_no         :string
#  created_by         :integer
#  created_date       :datetime
#  delivery_content   :text
#  delivery_place     :string
#  delivery_time      :date
#  description        :text
#  freight_charge     :float
#  last_modified_by   :integer
#  last_modified_date :datetime
#  money              :float
#  name               :string
#  number             :integer
#  order_no           :string
#  order_type         :string
#  payment_mode       :string
#  state              :string
#  tax                :string
#  type_name          :string
#  unit               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  company_id         :integer
#  owner_id           :integer
#
# Indexes
#
#  index_sales_on_company_id  (company_id)
#  index_sales_on_contact_no  (contact_no)
#  index_sales_on_order_no    (order_no)
#  index_sales_on_owner_id    (owner_id)
#

require 'rails_helper'

RSpec.describe Sale, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
