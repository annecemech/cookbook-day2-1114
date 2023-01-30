require "nokogiri"
require "open-uri"
require_relative "recipe.rb"

class RecipeScraper

  def initialize(keyword)
    @keyword = keyword
  end

  def call
    # Ouvrir l'URL Allrecipe (en interpolant le mot clé de l'utilisateur)
    url = "https://www.allrecipes.com/search?q=#{@keyword}"
    # Parser le document HTML
    doc = Nokogiri::HTML.parse(URI.open(url).read, nil, "utf-8")
    # Créer un array vide qui sera la liste des recettes
    results = []
    # Pour les 5 premières recettes
    doc.search(".mntl-document-card").each do |result|
      # Vérifier que l'élément est bien une recette (si elle a une note), et continuer si c'est le cas
      unless result.search(".recipe-card-meta__rating-count").empty?
        # Récupérer l'URl de la recette et ouvrir l'URL de la recette, puis parser le document HTML
        # L'ajouter dans la liste de recettes
        item = Nokogiri::HTML.parse(URI.open(result['href']).read, nil, "utf-8")
        # Récupérer le titre et stocker dans une variable
        title = item.search(".article-heading").text.strip
        # Récupérer la description et stocker dans une variable
        description = item.search(".article-subheading").text.strip
        # Récupérer le rating et stocker dans une variable
        rating = item.search(".mntl-recipe-review-bar__rating").text.strip
        # Récupérer le prep_time et stocker dans une variable
        prep_time = item.search(".mntl-recipe-details__value")[0].text.strip
        # Créer une instance de recette et la stocker dans un array
        results << Recipe.new({name: title, description: description, rating: rating, prep_time: prep_time})
      end
      # Interrompre la boucle lorsque le tableau des résultats contient 5 recettes
      break if results.size == 5
    end
    # Retourner le tableau des recettes
    results
  end

end
