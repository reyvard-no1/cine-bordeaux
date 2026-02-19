class MoviesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]

  def index
    @movies = case params[:filter]
              when 'popular'
                TmdbService.popular
              when 'upcoming'
                TmdbService.upcoming
              when 'now_playing'
                TmdbService.now_playing
              else
                TmdbService.popular
              end
  end

  def show
    @movie_id = params[:id]
    @movie_data = TmdbService.details(@movie_id)
    @trailer_key = TmdbService.trailer_key(@movie_id)

    # Charger depuis la DB si existe
    @movie = Movie.find_by(tmdb_id: @movie_id)

    # Vérifier si dans la wishlist de l'utilisateur
    @in_wishlist = current_user&.has_movie?(@movie) if @movie
  end

  def search
    @query = params[:query]
    @movies = TmdbService.search(@query) if @query.present?

    render :index
  end
end
