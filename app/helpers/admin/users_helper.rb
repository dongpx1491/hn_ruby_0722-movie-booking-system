module Admin::UsersHelper
  def total_payment user
    total = 0
    @payment = user.payments
    @payment.each{|payment| total += payment.total}
    total
  end
end
