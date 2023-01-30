class View
    def display(recipes)
        puts "-----------------------------"
        recipes.each_with_index do |recipe, index|
            recipe.done? ? status = "[X]" : status = "[ ]"
            puts "#{status} #{index + 1} : #{recipe.name} - #{recipe.prep_time} - #{recipe.rating}"
        end
        puts "-----------------------------"
    end

    def ask(param)
        puts "#{param}?"
        print "> "
        gets.chomp
    end

    def ask_index
        puts "Index?"
        print "> "
        gets.chomp.to_i - 1
    end

end
