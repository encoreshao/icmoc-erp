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

class UserDetail < ApplicationRecord
  extend Enumerize

  mount_uploader :avatar, UserAvatarUploader

  enumerize :gender, in: %i[female male], scopes: true, allow_nil: true
  enumerize :marriage, in: %i[single married], scopes: true, allow_nil: true
  enumerize :locale, in: %i[zh en], scopes: true

  validates_presence_of :name

  belongs_to :user
  belongs_to :theme

  after_commit :remove_avatar!, on: :destroy
  before_create :bind_theme!

  private

  def bind_theme!
    self.theme = Theme.random_theme
  end
end
