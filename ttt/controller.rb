require_relative "view"
require_relative "model"

class Controller
  include View

  def run!
    # game = Game.new
    Print::welcome
    Print::acceptable_moves
  end
end

Controller.new.run!
