class WishlistsController < ApplicationController
  before_action :authenticate_user!

  def index
    @wishlists = current_user.wishlists.includes(:movie).recent

    # Filtrer par statut si demandé
    @wishlists = @wishlists.public_send(params[:status]) if params[:status].present? && Wishlist.statuses.key?(params[:status])
  end

  def create
    @movie_data = TmdbService.details(params[:tmdb_id])

    # Créer ou trouver le film dans notre DB
    @movie = Movie.find_or_create_from_tmdb(@movie_data)

    # Ajouter le trailer si pas déjà présent
    if @movie.trailer_key.blank?
      trailer_key = TmdbService.trailer_key(@movie.tmdb_id)
      @movie.update(trailer_key: trailer_key) if trailer_key
    end

    # Créer la wishlist
    @wishlist = current_user.wishlists.build(movie: @movie)

    if @wishlist.save
      redirect_to wishlists_path, notice: "#{@movie.title} ajouté à votre wishlist !"
    else
      redirect_to movie_path(@movie.tmdb_id), alert: @wishlist.errors.full_messages.join(', ')
    end
  end

  def destroy
    @wishlist = current_user.wishlists.find(params[:id])
    movie_title = @wishlist.movie.title
    @wishlist.destroy

    redirect_to wishlists_path, notice: "#{movie_title} retiré de votre wishlist"
  end
end
