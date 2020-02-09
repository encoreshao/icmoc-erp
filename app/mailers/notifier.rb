# frozen_string_literal: true

class Notifier < ApplicationMailer
  def notify_admin(user, reimbursment)
    @user = user
    @reimbursment = reimbursment
    mail(to: "erp.reimbursment@#{APP_CONFIG['domain']}", subject: t('notity_reimbursement_subject_to_admin'))
  end

  def notify_user(user, reimbursment)
    @user = user
    @reimbursment = reimbursment
    mail(to: @user.email, subject: t('notity_reimbursement_subject_to_user'))
  end

  def notify_contract(users, item)
    emails = users.map(&:email)

    @users = users
    @item = item
    mail(to: emails, subject: "#{@item[:name].capitalize} notification")
  end
end
