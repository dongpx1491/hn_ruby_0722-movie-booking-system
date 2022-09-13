class Admin::GenresController < Admin::AdminController
  before_action :find_genre, only: %i(edit update destroy)
  authorize_resource

  def index
    @pagy, @genres = pagy Genre.asc_genre_name
  end

  def new
    @genre = Genre.new
  end

  def edit; end

  def update
    if @genre.update genre_params
      flash[:success] = t "genre_updated"
      redirect_to admin_genres_path
    else
      flash[:danger] = t "genre_update_failed"
      render :edit
    end
  end

  def destroy
    if @genre.movies.any?
      flash[:danger] = t "delete_denied"
    elsif @genre.destroy
      flash[:success] = t "genre_delete"
    else
      flash[:danger] = t "genre_delete_failed"
    end
    redirect_to admin_genres_path
  end

  def create
    @genre = Genre.new genre_params
    if @genre.save
      flash[:success] = t "genre_create"
      redirect_to admin_genres_path
    else
      flash[:danger] = t "genre_create_failed"
      render :new
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end

  def find_genre
    @genre = Genre.find_by id: params[:id]
    return if @genre

    flash[:danger] = t "not_found"
    redirect_to root_path
  end
end
