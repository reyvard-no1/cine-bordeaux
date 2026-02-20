class CheckNewReleasesJob < ApplicationJob
  queue_as :default

  def perform
    # Date d'aujourd'hui
    today = Date.today

    Rails.logger.info "🎬 CheckNewReleases Job - Vérification des sorties du #{today.strftime('%d/%m/%Y')}"

    # Compter les notifications envoyées
    notifications_sent = 0

    # Récupérer toutes les wishlists non notifiées avec un film
    Wishlist.includes(:movie, :user).not_notified.find_each do |wishlist|
      movie = wishlist.movie

      # Vérifier si le film sort aujourd'hui
      if movie.release_date == today
        Rails.logger.info "  📧 Film sorti : #{movie.title} - Envoi email à #{wishlist.user.email}"

        # Envoyer l'email
       ::MovieMailer.release_notification(wishlist.user, movie).deliver_later

        # Marquer comme notifié
        wishlist.mark_as_notified!

        notifications_sent += 1
      end
    end

    Rails.logger.info "✅ Job terminé : #{notifications_sent} notification(s) envoyée(s)"
  end
end
