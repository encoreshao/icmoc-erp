# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  active                 :boolean          default(FALSE)
#  admin                  :string
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  subject                :string
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#

class User < ApplicationRecord
  extend Enumerize
  include CommonScope

  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  enumerize :subject, in: %i[trainee employee], scopes: true, default: :employee, allow_nil: true

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  has_one :detail,
          class_name: 'UserDetail',
          primary_key: 'id',
          foreign_key: 'user_id'
  has_one :theme, through: :detail

  delegate :name, to: :detail, allow_nil: true
  delegate :avatar, to: :detail, allow_nil: true

  accepts_nested_attributes_for :roles, allow_destroy: true
  accepts_nested_attributes_for :detail, allow_destroy: true

  before_create :setup_attrs

  def role?(role)
    roles.find_by_name(role.to_s.camelize)
  end

  def role_names
    roles.map(&:name).join(',')
  end

  def permissions
    @permissions ||= roles.map(&:permissions).flatten
  end

  def display_name
    name || email
  end

  class << self
    def members
      all.select('id').includes([:detail]).map { |e| [e.name, e.id] }
    end
  end

  def theme_image_url
    (theme&.image || Theme.default_image).url
  end

  def theme_appearance
    (theme || Theme.default_theme).appearance
  end

  def locale
    detail.locale&.to_sym
  end

  protected

  def setup_attrs
    confirmed_at = Time.zone.now
  end
end
