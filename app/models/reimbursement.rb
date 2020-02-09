# frozen_string_literal: true

# == Schema Information
#
# Table name: reimbursements
#
#  id             :integer          not null, primary key
#  project_id     :integer
#  user_id        :integer
#  state          :string
#  episodes_count :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Reimbursement < ApplicationRecord
  include AASM
  extend Enumerize

  validates :user_id, :state, presence: true

  belongs_to :user
  belongs_to :project
  has_many :episodes, dependent: :destroy

  enumerize :state, in: %i[pending confirmed paid], scopes: true, methods: true, default: :pending

  accepts_nested_attributes_for :episodes, allow_destroy: true

  aasm column: :state do
    state :pending, initial: true
    state :confirmed
    state :paid

    event :confirm, after_commit: :notify_user do
      transitions from: :pending, to: :confirmed
    end

    event :pay do
      transitions from: :confirmed, to: :paid
    end
  end

  scope :with_user, ->(uid) { where(user_id: uid) }

  scope :unprocessed, -> { where(state: %i[pending confirmed]) }

  def reject_episodes(attributed)
    attributed['activity_date'].blank? || attributed['usage'].blank? || attributed['amount'].blank?
  end

  def amount
    episodes.collect(&:amount).sum
  end

  def people_count
    episodes.collect(&:count).sum
  end

  def amount_exceed?
    amount > (days_count * people_count)
  end

  def detail_submit_date
    "#{I18n.t(:'date.day_names')[created_at.wday]} - #{created_at.to_date.strftime('%Y-%m-%d')}"
  end

  def notify_user
    # Notifier
  end
end
