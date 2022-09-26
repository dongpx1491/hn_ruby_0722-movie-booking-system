class Admin::ShowsController < Admin::AdminController
  before_action :find_show, only: %i(edit update destroy)
  before_action :load_movie_room, except: %i(index destroy)
  authorize_resource

  def index
    @search = Show.ransack params[:q]
    @pagy, @shows = pagy @search.result.incre_order,
                         items: Settings.model.limited
  end

  def new
    @show = Show.new
  end

  def create
    @show = Show.new show_params
    if @show.save
      flash[:success] = t "show_create"
      redirect_to admin_shows_path
    else
      flash[:danger] = t "show_create_failed"
      render :new
    end
  end

  def edit; end

  def update
    if @show.update show_params
      flash[:success] = t "movie_update"
      redirect_to admin_shows_path
    else
      flash[:danger] = t "movie_update_failed"
      render :edit
    end
  end

  def destroy
    if @show.tickets.any?
      flash[:success] = t "show_delete_denied"
    elsif @show.destroy
      flash[:success] = t "show_delete"
    else
      flash[:danger] = t "show_delete_failed"
    end
    redirect_to admin_shows_path
  end

  private
  def show_params
    params.require(:show).permit Show::SHOW_ATTR
  end

  def find_show
    @show = Show.find_by id: params[:id]
    return if @show

    flash[:danger] = t "not_found"
    redirect_to root_path
  end

  def load_movie_room
    @movies = Movie.active.incre_order
    @rooms = Room.incre_order
  end
end
