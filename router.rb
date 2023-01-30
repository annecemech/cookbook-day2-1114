class Router
    # responsabilité renvoyer vers le bon controller et la bonne action
    def initialize(controller)
        @controller = controller
    end

    def run
        stop = false
        while !stop
            display_menu
            action = gets.chomp.to_i
            stop = dispatch(action)
        end
    end

    private

    def display_menu
        puts "1 - List recipes"
        puts "2 - Add a recipe"
        puts "3 - Remove recipe"
        puts "4 - Import recipe from Allrecipe"
        puts "5 - Mark recipe as done"
        puts "6 - Stop"
    end

    def dispatch(action)
        stop = false
        case action
        when 1 then @controller.list
        when 2 then @controller.add
        when 3 then @controller.remove
        when 4 then @controller.import
        when 5 then @controller.mark_recipe_as_done
        when 6 then stop = true
        end
        stop
    end

end
