class DailyOrderWorker
  include Sidekiq::Worker

  def perform
    UserMailer.daily_revenue.deliver_later
  end
end
