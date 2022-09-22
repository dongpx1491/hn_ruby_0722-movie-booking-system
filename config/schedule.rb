set :environment, "development"
set :output, "log/cron_log.log"
env :PATH, ENV["PATH"]

#check_expiration of payments every 15 minutes
every 1.minutes do
  rake "delete_namespace:delete_payments_expired", environment: "development"
end

# send mail every end of the day
every "55 23 * * *" do
  rake "daily_namespace:send_mail_daily", :environment => "development"
end

# send mail every last day of the month
every "55 23 30 4,6,9,11 *" do
  rake "monthly_namespace:send_mail_monthly", :environment => "development"
end

every "55 23 31 1,3,5,7,8,10,12 *" do
  rake "monthly_namespace:send_mail_monthly", :environment => "development"
end

every "55 23 28 2 *" do
  rake "monthly_namespace:send_mail_monthly", :environment => "development"
end
