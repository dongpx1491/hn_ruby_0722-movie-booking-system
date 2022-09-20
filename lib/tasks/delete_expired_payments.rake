require "rake"
namespace :delete_namespace do
  desc "delete payments expired"
  task delete_payments_expired: :environment do
    @payments = Payment.inactive
    @payments.map do |payment|
      payment.destroy if payment.payment_expired?
    end
  end
end
