class ApplicationMailer < ActionMailer::Base
  include Admin::PaymentsHelper

  default from: ENV["host_email"]
  layout "mailer"
end
