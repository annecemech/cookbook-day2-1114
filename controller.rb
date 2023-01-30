require_relative "view.rb"
require_relative "recipe.rb"
require_relative "recipe_scraper.rb"

class Controller
    # Responsabilité: Demander aux autres
    def initialize(cookbook)
        @cookbook = cookbook
        @view = View.new
    end

    def list
        # Demander à cookbook la liste des recipes et la stocker dans une variable
        recipes = @cookbook.all
        # Demander à view de l'afficher à l'utilisateur
        @view.display(recipes)
    end

    def add
        # Demander à la vue de demander au user, le nom de la recette et le stocker dans une variable
        name = @view.ask("Name")
        # Demander à la vue de demander au user, la description de la recette et le stocker dans une variable
        description = @view.ask("Description")
        # Demander à la vue de demander au user, le rating de la recette et le stocker dans une variable
        rating = @view.ask("Rating")
        # Demander à la vue de demander au user, le prep time de la recette et le stocker dans une variable
        prep_time = @view.ask("Prep Time")
        # Demander à Recipe de créer une recipe et la stocker dans une variable
        recipe = Recipe.new(name: name, description: description, rating: rating, prep_time: prep_time)
        # Demander à cookbook de l'ajouter à la liste
        @cookbook.create(recipe)
    end

    def remove
        # Demander à la vue de demander au user, l'index de la recette et le stocker dans une variable
        index = @view.ask_index
        # Demander à cookbook de le retirer de la liste
        @cookbook.destroy(index)
    end

    def import
      # Demander à l'utilisateur le nom d'un ingrédient et le stocker dans une variable
      keyword = @view.ask("Keyword")
      # Appeler le service pour scrapper AllRecipe
      results = RecipeScraper.new(keyword).call
      # Afficher la liste des recettes à l'utilisateur
      @view.display(results)
      # Demander quel est l'index de la recette qu'il veut
      index = @view.ask_index
      # Ajouter la recette au cookbook
      @cookbook.create(results[index])
      # Afficher les recettes du cookbook à l'utilisateur
      list
    end

    def mark_recipe_as_done
      list
      index = @view.ask_index
      @cookbook.mark_recipe(index)
      list
    end


end
