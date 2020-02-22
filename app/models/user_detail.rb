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
#  marriage       :string
#  mobile_phone   :string
#  name           :string
#  nationality    :string
#  position       :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  theme_id       :integer
#  user_id        :bigint
#
# Indexes
#
#  index_user_details_on_user_id  (user_id)
#

class UserDetail < ApplicationRecord
  extend Enumerize

  mount_uploader :avatar, UserAvatarUploader

  enumerize :gender, in: %i[female male], scopes: true, allow_nil: true
  enumerize :marriage, in: %i[single married], scopes: true, allow_nil: true

  validates_presence_of :name

  belongs_to :user
  belongs_to :theme

  after_commit :remove_avatar!, on: :destroy
end
