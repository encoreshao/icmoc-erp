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

class UserDetail < ApplicationRecord
  extend Enumerize

  mount_uploader :avatar, UserAvatarUploader

  enumerize :gender, in: %i[female male], scopes: true, allow_nil: true
  enumerize :marriage, in: %i[single married], scopes: true, allow_nil: true

  validates_presence_of :name

  belongs_to :user

  after_commit :remove_avatar!, on: :destroy
end
