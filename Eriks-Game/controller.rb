require_relative 'view'
require_relative 'model'

class WallController
  include WallView

  def run!
    wall = Wall.new
    drinker = Drinker.new

    Print::run_spinner
    Print::title_screen

    loop do
      Print::menu
      case Print::fetch_user_input
      when "c"
        Print::count_bottles(wall.bottles)
      when "a"
        wall.add_bottle(Print::serialize_bottle)
      when "d"
        if wall.empty?
          Print::empty_message
          exit
        end
        wall.drink_bottle(Print::drink_id(wall.bottles).to_i, drinker)
        if drinker.drunk?
          Print::drunk_message
        end
      when "q"
        puts "Goodbye!"
        exit
      else
        Print::error_message
      end
    end
  end
end

WallController.new.run!
