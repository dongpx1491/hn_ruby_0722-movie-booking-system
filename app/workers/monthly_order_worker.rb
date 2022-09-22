class DailyOrderWorker
  include Sidekiq::Worker

  def perform
    UserMailer.monthly_revenue.deliver_now
  end
end
