class ActivePaymentWorker
  include Sidekiq::Worker
  def perform payment_id
    @payment = Payment.find_by id: payment_id
    return Sidekiq.logger.error(" Cannot found payment") unless @payment

    @payment.create_activation_digest
    @payment.send_activation_email
  end
end
