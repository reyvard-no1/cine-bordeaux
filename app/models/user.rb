class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :wishlists, dependent: :destroy
  has_many :movies, through: :wishlists

  validates :name, presence: true


  # Retourne les films à venir dans la wishlist
  def upcoming_movies
    movies.where('release_date > ?', Date.today).order(release_date: :asc)
  end

  # Retourne les films actuellement en salle
  def current_movies
    movies.where('release_date <= ?', Date.today).order(release_date: :desc)
  end

  # Vérifie si un film est dans la wishlist
  def has_movie?(movie)
    movies.include?(movie)
  end
end
