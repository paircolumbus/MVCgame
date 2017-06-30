require_relative 'view'
require_relative 'model'

class GameController
  include GameView
  def run!
    catList = List.new
    Print::run_spinner
    Print::title_screen

    loop do
      Print::menu
      case Print::fetch_user_input
      when "V"
        Print::print_list(catList.cats)
      when "A"
        catList.add_cat(Print::seerialize_cat)
      when "F"
        catList.feed_cat(Print::fed_id.to_i)
      when "S"
        catList.sell_cat(Print::sold_id.to_i)
      when "Q"
        puts "we're Done"
        exit
      else
        Print::error_message
      end
    end
  end
end
GameController.new.run!
