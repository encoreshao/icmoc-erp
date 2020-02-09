# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  admin                  :string
#  subject                :string
#  active                 :boolean          default("false")
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default("0"), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
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

  accepts_nested_attributes_for :roles, allow_destroy: true
  accepts_nested_attributes_for :detail, allow_destroy: true

  before_create :setup_attrs

  def role?(role)
    roles.find_by_name(role.to_s.camelize)
  end

  def role_names
    roles.map(&:name).join(',')
  end

  def display_name
    detail.try(:name) || email
  end

  class << self
    def members
      all.select('id').includes([:detail]).map { |e| [e.detail.try(:name), e.id] }
    end
  end

  protected

  def setup_attrs
    confirmed_at = Time.zone.now
  end
end
