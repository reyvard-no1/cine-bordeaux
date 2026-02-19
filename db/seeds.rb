# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "🎬 Création des cinémas de Bordeaux..."

Cinema.destroy_all

cinemas = [
  {
    name: "UGC Ciné Cité Bordeaux",
    address: "13-15 Rue Georges Bonnac",
    city: "Bordeaux",
    postal_code: "33000",
    phone: "0892 70 00 00",
    website: "https://www.ugc.fr/cinema.html?id=23",
    latitude: 44.841225,
    longitude: -0.574552,
    description: "Multiplexe de 13 salles au cœur de Bordeaux. Dernières technologies de projection et son. Programmation variée : blockbusters, films d'auteur et avant-premières."
  },
  {
    name: "CGR Dragon - Talence",
    address: "Allée René Laroumagne, Place du Forum",
    city: "Talence",
    postal_code: "33400",
    phone: "0892 68 91 23",
    website: "https://dragon.cgrcinemas.fr",
    latitude: 44.806944,
    longitude: -0.590833,
    description: "Cinéma moderne de 7 salles sur la Place du Forum à Talence. Proche université et tram B. Programmation éclectique et tarifs étudiants. Écran ICE immersif."
  },
  {
    name: "Le Français",
    address: "5 Rue Montesquieu",
    city: "Bordeaux",
    postal_code: "33000",
    phone: "05 56 52 66 52",
    website: "https://www.lefrancais-bordeaux.com",
    latitude: 44.842222,
    longitude: -0.574167,
    description: "Cinéma d'art et essai historique près de la Place des Grands Hommes. 3 salles intimistes au charme rétro. Programmation exigeante : films d'auteur, documentaires, cycles thématiques. Bar et espace convivial."
  },
  {
    name: "Jean Eustache",
    address: "Place de la Ve République",
    city: "Pessac",
    postal_code: "33600",
    phone: "05 56 46 00 96",
    website: "https://www.cinemajohaneustache.fr",
    latitude: 44.805556,
    longitude: -0.631944,
    description: "Cinéma municipal de Pessac. 3 salles confortables avec programmation Art et Essai. Tarifs attractifs et séances tout public. Proche du campus universitaire et du tram B."
  },
  {
    name: "CGR Bordeaux - Bouscat",
    address: "2 Avenue du Maréchal de Lattre de Tassigny",
    city: "Le Bouscat",
    postal_code: "33110",
    phone: "05 56 17 07 57",
    website: "https://bordeaux.cgrcinemas.fr",
    latitude: 44.868889,
    longitude: -0.597778,
    description: "Cinéma moderne de 8 salles avec écran IMAX. Confort optimal avec fauteuils inclinables. Carte illimitée CGR disponible."
  },
  {
    name: "Utopia Bordeaux",
    address: "5 Place Camille Jullian",
    city: "Bordeaux",
    postal_code: "33000",
    phone: "05 56 52 00 03",
    website: "https://www.cinema-utopia.org/bordeaux",
    latitude: 44.837778,
    longitude: -0.571389,
    description: "Cinéma d'art et essai indépendant. 5 salles intimistes. Programmation exigeante : cinéma d'auteur, documentaires, films du monde entier. Bar-restaurant associatif."
  },
  {
    name: "Mégarama Bordeaux Villenave d'Ornon",
    address: "Rue Louis Blériot - ZAC du Chemin Long",
    city: "Villenave-d'Ornon",
    postal_code: "33140",
    phone: "0892 68 00 31",
    website: "https://www.megarama.fr/bordeaux",
    latitude: 44.774722,
    longitude: -0.552222,
    description: "Le plus grand multiplexe de la région avec 16 salles. Écran géant, salles VIP et 4DX. Grand parking gratuit. Idéal pour les sorties en famille."
  },
  {
    name: "Jean Vigo",
    address: "6 Rue Franklin",
    city: "Bordeaux",
    postal_code: "33000",
    phone: "05 56 44 35 17",
    website: "https://www.cinema-jean-vigo.fr",
    latitude: 44.833056,
    longitude: -0.569444,
    description: "Cinéma associatif et ciné-club historique. 1 salle de 160 places. Programmation pointue : rétrospectives, cycles thématiques, rencontres avec réalisateurs."
  },
  {
    name: "CGR Mériadeck",
    address: "3 Cours du Maréchal Juin",
    city: "Bordeaux",
    postal_code: "33000",
    phone: "05 56 99 77 82",
    website: "https://meriadeck.cgrcinemas.fr",
    latitude: 44.836111,
    longitude: -0.582222,
    description: "Cinéma du quartier Mériadeck. 8 salles dont 1 ICE (expérience immersive). Proche des commerces et bureaux. Idéal après le travail."
  }
]

cinemas.each do |cinema_data|
  cinema = Cinema.create!(cinema_data)
  puts "✅ #{cinema.name} créé"
end

puts "🎉 #{Cinema.count} cinémas créés !"
