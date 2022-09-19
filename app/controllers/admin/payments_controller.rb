class Admin::PaymentsController < Admin::AdminController
  before_action :find_show, except: %i(index)
  before_action :load_ticket, only: %i(show)
  authorize_resource

  def index
    @search = Show.ransack params[:q]
    @pagy, @shows = pagy @search.result.asc_date,
                         items: Settings.model.limited
  end

  def show
    respond_to :js
  end

  def edit; end

  private
  def payment_params
    params.require(:payment).permit(:status)
  end

  def find_show
    @show = Show.find_by id: params[:id]
    return if @show

    flash[:danger] = t "not_found"
    redirect_to admin_payments_path
  end

  def load_ticket
    @tickets = @show.tickets
    return if @tickets

    flash[:danger] = t "not_found"
    redirect_to admin_payments_path
  end
end
