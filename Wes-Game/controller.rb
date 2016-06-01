require_relative 'view'
require_relative 'model'

class GameController
  include GameView

  def run!
    wineList = List.new

    loop do
      Print::menu
      case Print::fetch_user_input
      when "V"
        Print::print_list(wineList.wines)
      when "A"
        wineList.add_wine(Print::serialize_wine)
      when "D"
        wineList.delete_wine(Print::deleted_name)
      when "Q"
        puts "We're done"
        exit
      else
        Print::error_message
      end
    end
  end
end

GameController.new.run!
