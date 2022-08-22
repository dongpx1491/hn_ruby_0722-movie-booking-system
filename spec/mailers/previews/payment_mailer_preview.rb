# Preview all emails at http://localhost:3000/rails/mailers/payment_mailer
class PaymentMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/payment_mailer/payment_activation
  def payment_activation
    PaymentMailer.payment_activation
  end

  # Preview this email at http://localhost:3000/rails/mailers/payment_mailer/confirm_payment
  def confirm_payment
    PaymentMailer.confirm_payment
  end

end
