class PaymentMailer < ApplicationMailer
  def payment_activation payment
    @payment = payment
    @user = @payment.user

    mail to: @user.email, subject: (t ".subject")
  end
end
