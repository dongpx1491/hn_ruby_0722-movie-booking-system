class TicketsController < ApplicationController
  before_action :logged_in_user

  def show; end

  def create
    @ticket = Ticket.new ticket_params
    if @ticket.save
      flash[:success] = t ".success"
      total_price @ticket
    else
      flash[:danger] = t ".danger"
    end
    redirect_to movie_show_path(params[:movie_id], params[:ticket][:show_id])
  end

  def destroy; end

  private

  def ticket_params
    params.require(:ticket).permit(:show_id, :seat_id, :payment_id)
  end
end
