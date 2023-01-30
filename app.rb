require_relative "router.rb"
require_relative "controller.rb"
require_relative "cookbook.rb"

cookbook = Cookbook.new("recipes.csv")
controller = Controller.new(cookbook)
router = Router.new(controller)

router.run