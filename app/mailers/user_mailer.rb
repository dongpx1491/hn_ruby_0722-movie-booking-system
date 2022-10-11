class UserMailer < ApplicationMailer
  def account_activation user
    @user = user

    mail to: user.email, subject: t(".activation")
  end

  def password_reset user
    @user = user

    mail to: user.email, subject: t(".reset_subject")
  end

  def daily_revenue
    today = Time.zone.today
    @shows = Show.created_date today
    @total_revenue_daily = 0
    @shows.all.each do |show|
      @total_revenue_daily += revenue(show)
    end
    email = "admin@gmail.com"
    mail to: email, subject: t(".daily_revenue")
  end

  def monthly_revenue
    month = Time.zone.today.month
    year = Time.zone.today.year
    @movies = Movie.joins(:shows).where("month(date)=?", month).group(:movie_id)
    @shows_in_month = Show.created_month month, year
    @total_revenue_monthly = 0
    @shows_in_month.all.each do |show|
      @total_revenue_monthly += revenue(show)
    end
    email = "admin@gmail.com"
    mail to: email, subject: t(".monthly_revenue")
  end

  private
  helper_method def revenue show
    revenue = 0
    @tickets = show.tickets
    @tickets.each do |ticket|
      revenue += ticket.seat.price if ticket.payment.active?
    end
    revenue
  end

  helper_method def movie_revenue movie
    revenue = 0
    @shows = movie.shows
    @shows.each do |show|
      revenue += revenue(show)
    end
    revenue
  end
end
