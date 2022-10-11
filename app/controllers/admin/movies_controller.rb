class Admin::MoviesController < Admin::AdminController
  before_action :find_movie, only: %i(edit update destroy)
  before_action :load_genre, except: %i(index destroy)
  authorize_resource

  def index
    @search = Movie.ransack params[:q]
    @pagy, @movies = pagy @search.result.incre_order,
                          items: Settings.model.limited
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new movie_params
    @movie.image.attach(params[:movie][:image])
    if @movie.save
      flash[:success] = t "movie_create"
      redirect_to admin_movies_path
    else
      flash[:danger] = t "movie_create_failed"
      render :new
    end
  end

  def edit; end

  def update
    if params.dig(:movie, :status_before_type_cast)
      update_active
    else
      update_all
    end
  end

  def destroy
    if @movie.shows.any?
      flash[:danger] = t "movie_delete_denied"
    elsif @movie.destroy
      flash[:success] = t "movie_delete"
    else
      flash[:danger] = t "movie_delete_failed"
    end
    redirect_to admin_movies_path
  end

  private
  def movie_params
    params.require(:movie).permit Movie::MOVIE_ATTR
  end

  def find_movie
    @movie = Movie.find_by id: params[:id]
    return if @movie

    flash[:danger] = t "not_found"
    redirect_to root_path
  end

  def load_genre
    @genres = Genre.asc_genre_name
  end

  def update_active
    if @movie.shows.empty?
      if @movie.update_column(:status,
                              params.dig(:movie, :status_before_type_cast))
        flash[:success] = t("success")
      else
        flash[:danger] = t("danger")
      end
    else
      flash[:danger] = t("movie_update_denied")
    end
    redirect_to admin_movies_path
  end

  def update_all
    if @movie.update movie_params
      flash[:success] = t(".success")
      redirect_to admin_movies_path
    else
      render :edit
    end
  end
end
