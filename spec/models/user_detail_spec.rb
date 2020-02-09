# frozen_string_literal: true

# == Schema Information
#
# Table name: user_details
#
#  id             :integer          not null, primary key
#  name           :string
#  avatar         :string
#  address        :string
#  mobile_phone   :string
#  gender         :string
#  position       :string
#  age            :integer
#  birthday       :date
#  marriage       :string
#  hiredate       :date
#  country        :string
#  birthplace     :string
#  nationality    :string
#  id_card_no     :string
#  user_id        :integer
#  contact_person :string
#  contact_phone  :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe UserDetail, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
