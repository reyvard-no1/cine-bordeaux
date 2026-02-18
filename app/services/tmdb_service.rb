require 'net/http'
require 'json'

class TmdbService
  BASE_URL = 'https://api.themoviedb.org/3'

  class << self
    # Rechercher des films
    def search(query, page: 1)
      return [] if query.blank?

      endpoint = '/search/movie'
      params = {
        query: query,
        language: 'fr-FR',
        page: page
      }

      response = make_request(endpoint, params)
      response['results'] || []
    end

    # Films populaires
    def popular(page: 1)
      endpoint = '/movie/popular'
      params = {
        language: 'fr-FR',
        page: page,
        region: 'FR'
      }

      response = make_request(endpoint, params)
      response['results'] || []
    end

    # Films à venir
    def upcoming(page: 1)
      endpoint = '/movie/upcoming'
      params = {
        language: 'fr-FR',
        page: page,
        region: 'FR'
      }

      response = make_request(endpoint, params)
      response['results'] || []
    end

    # Films actuellement en salle
    def now_playing(page: 1)
      endpoint = '/movie/now_playing'
      params = {
        language: 'fr-FR',
        page: page,
        region: 'FR'
      }

      response = make_request(endpoint, params)
      response['results'] || []
    end

    # Détails d'un film
    def details(movie_id)
      endpoint = "/movie/#{movie_id}"
      params = {
        language: 'fr-FR',
        append_to_response: 'videos,credits'
      }

      make_request(endpoint, params)
    end

    # Récupérer la clé du trailer
    def trailer_key(movie_id)
      details = details(movie_id)
      videos = details.dig('videos', 'results') || []

      # Chercher le trailer officiel en français, sinon en anglais
      trailer = videos.find { |v| v['type'] == 'Trailer' && v['site'] == 'YouTube' }
      trailer&.dig('key')
    end

    private

    # Méthode générique pour faire des requêtes
    def make_request(endpoint, params = {})
      api_key = ENV['TMDB_API_KEY']

      if api_key.blank?
        Rails.logger.error 'TMDB_API_KEY not found in environment variables'
        return {}
      end

      # Ajouter la clé API aux paramètres
      params[:api_key] = api_key

      # Construire l'URL complète
      uri = URI("#{BASE_URL}#{endpoint}")
      uri.query = URI.encode_www_form(params)

      begin
        response = Net::HTTP.get_response(uri)

        if response.is_a?(Net::HTTPSuccess)
          JSON.parse(response.body)
        else
          Rails.logger.error "TMDB API Error: #{response.code} - #{response.message}"
          {}
        end
      rescue StandardError => e
        Rails.logger.error "TMDB API Request failed: #{e.message}"
        {}
      end
    end
  end
end
