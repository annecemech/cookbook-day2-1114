require "csv"
require "pry-byebug"

class Cookbook
    # Responsabilité: gestion de la liste
    def initialize(csv_file)
        @recipes = []
        @csv_file = csv_file
        parse_to_csv
    end

    def all
        @recipes
    end

    def create(recipe)
        @recipes << recipe
        store_in_csv
    end

    def destroy(recipe_index)
        @recipes.delete_at(recipe_index)
        store_in_csv
    end

    def mark_recipe(index)
      recipe = @recipes[index]
      recipe.mark_as_done!
      store_in_csv
    end

    private

    def parse_to_csv
        CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
            row[:done] == "true" ? row[:done] = true : row[:done] = false
            recipe = Recipe.new(name: row[:name], description: row[:description], rating: row[:rating], done: row[:done], prep_time: row[:prep_time])
            @recipes << recipe
            # @recipes << Recipe.new(name: row[0], description: row[1])
        end
    end

    def store_in_csv
        CSV.open(@csv_file, "wb") do |csv|
            csv << ["name", "description", "rating", "done", "prep_time"]
            @recipes.each do |recipe|
                csv << [recipe.name, recipe.description, recipe.rating, recipe.done?, recipe.prep_time]
            end
        end
    end
end
