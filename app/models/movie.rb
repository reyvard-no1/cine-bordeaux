class Movie < ApplicationRecord
  has_many :wishlists, dependent: :destroy
  has_many :users, through: :wishlists


  validates :tmdb_id, presence: true, uniqueness: true
  validates :title, presence: true


  scope :upcoming, -> { where("release_date > ?", Date.today).order(release_date: :asc) }
  scope :in_theaters, -> { where("release_date <= ? AND release_date > ?", Date.today, 3.months.ago).order(release_date: :desc) }
  scope :by_genre, ->(genre) { where("genres LIKE ?", "%#{genre}%") }
  # affiche méthode
  def poster_full_url
    return nil unless poster_url
    "https://image.tmdb.org/t/p/w500#{poster_url}"
  end

  # bannière
  def backdrop_full_url
    return nil unless backdrop_url
    "https://image.tmdb.org/t/p/original#{backdrop_url}"
  end

  #  miniature
  def poster_thumbnail_url
    return nil unless poster_url
    "https://image.tmdb.org/t/p/w200#{poster_url}"
  end

  # trailer YouTube
  def trailer_url
    return nil unless trailer_key
    "https://www.youtube.com/watch?v=#{trailer_key}"
  end

  # Embed URL pour YouTube
  def trailer_embed_url
    return nil unless trailer_key
    "https://www.youtube.com/embed/#{trailer_key}"
  end

  # Vérifie si le film est déjà sorti
  def released?
    release_date && release_date <= Date.today
  end

  # Vérifie si le film sort bientôt ou dans les 30 prochains jours
  def upcoming?
    release_date && release_date > Date.today && release_date <= 30.days.from_now
  end

  # Retourne l'année de sortie
  def release_year
    release_date&.year
  end

  # Génère un tableau de genres depuis la string
  def genre_list
    return [] unless genres
    genres.split(",").map(&:strip)
  end

  # ====================
  # MÉTHODES DE CLASSE
  # ====================

  # Trouve ou crée un film depuis les données TMDB
  def self.find_or_create_from_tmdb(tmdb_data)
    movie = find_or_initialize_by(tmdb_id: tmdb_data["id"])

    movie.assign_attributes(
      title: tmdb_data["title"],
      synopsis: tmdb_data["overview"],
      poster_url: tmdb_data["poster_path"],
      backdrop_url: tmdb_data["backdrop_path"],
      release_date: tmdb_data["release_date"],
      genres: tmdb_data["genres"]&.map { |g| g["name"] }&.join(", "),
      cached_data: tmdb_data.to_json
    )

    movie.save
    movie
  end
end
