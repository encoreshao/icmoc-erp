# frozen_string_literal: true

# == Schema Information
#
# Table name: companies
#
#  id                 :integer          not null, primary key
#  name               :string
#  address            :string
#  country            :string
#  city               :string
#  contact_person     :string
#  telephone          :string
#  website            :string
#  fax                :string
#  postcode           :string
#  logo               :string
#  description        :text
#  industry           :string
#  nature_of_business :string
#  introduction       :text
#  tax_no             :string
#  legal_person       :string
#  bank_address       :string
#  bank_account       :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe Company, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
