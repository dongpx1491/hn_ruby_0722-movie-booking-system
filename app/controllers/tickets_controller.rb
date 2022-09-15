class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_ticket, only: :destroy
  authorize_resource

  def create
    @ticket = Ticket.new ticket_params
    if @ticket.save
      flash[:success] = t ".success"
      add_total_price @ticket
    else
      flash[:danger] = t ".danger"
    end
    redirect_to movie_show_path(params[:movie_id], params[:ticket][:show_id])
  end

  def destroy
    if @ticket.destroy
      flash[:success] = t ".success"
      minus_total_price @ticket
    else
      flash[:danger] = t ".danger"
    end
    redirect_to payment_path(current_payment)
  end

  private

  def find_ticket
    @ticket = Ticket.find_by id: params[:id]
    return if @ticket

    flash[:warning] = t ".not_found"
    redirect_to root_path
  end

  def ticket_params
    params.require(:ticket).permit(:show_id, :seat_id, :payment_id)
  end
end
