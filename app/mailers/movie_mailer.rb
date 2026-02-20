class MovieMailer < ApplicationMailer
  default from: 'notifications@cine-bordeaux.fr'

  def release_notification(user, movie)
    @user = user
    @movie = movie

    mail(
      to: @user.email,
      subject: "🎬 #{@movie.title} est sorti en salle !"
    )
  end
end
