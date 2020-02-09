# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "notifier@#{APP_CONFIG['domain']}"

  layout 'mailer'
end
