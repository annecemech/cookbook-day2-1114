class Recipe
    attr_reader :name, :description, :rating, :prep_time

    def initialize(attrs)
        @name = attrs[:name]
        @description = attrs[:description]
        @rating = attrs[:rating]
        @done = attrs[:done] || false
        @prep_time = attrs[:prep_time]
    end

    def done?
      @done
    end

    def mark_as_done!
      @done = !@done
    end

end
