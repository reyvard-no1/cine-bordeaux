class Wishlist < ApplicationRecord

  belongs_to :user
  belongs_to :movie

  validates :user_id, uniqueness: {
    scope: :movie_id,
    message: "a déjà ce film dans sa wishlist"
  }


 enum :status, { to_watch: 0, watching: 1, watched: 2 }, default: :to_watch
  # callbacks
  after_initialize :set_defaults, if: :new_record?


  scope :not_notified, -> { where(notified: false) }
  scope :to_watch, -> { where(status: 'to_watch') }
  scope :recent, -> { order(created_at: :desc) }



  # Marquer comme notifié
  def mark_as_notified!
    update(notified: true)
  end

  # Vérifier si le film doit être notifié (sorti et pas encore notifié)
  def should_notify?
    !notified && movie.released?
  end

  private

  def set_defaults
    self.notified ||= false
    self.status ||= 'to_watch'
  end
end
