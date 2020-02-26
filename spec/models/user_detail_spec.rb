# frozen_string_literal: true

# == Schema Information
#
# Table name: user_details
#
#  id             :bigint           not null, primary key
#  address        :string
#  age            :integer
#  avatar         :string
#  birthday       :date
#  birthplace     :string
#  contact_person :string
#  contact_phone  :string
#  country        :string
#  gender         :string
#  hiredate       :date
#  id_card_no     :string
#  locale         :string
#  marriage       :string
#  mobile_phone   :string
#  name           :string
#  nationality    :string
#  position       :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  theme_id       :bigint
#  user_id        :bigint
#
# Indexes
#
#  index_user_details_on_theme_id  (theme_id)
#  index_user_details_on_user_id   (user_id)
#

require 'rails_helper'

RSpec.describe UserDetail, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
