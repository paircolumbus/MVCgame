require_relative 'view'
require_relative 'model'

class TTTController

  def run!
    board = TTT.new
    view = TTTView.new board

    view.print_title

    #Make todoList methods like RESTful endpoints (new/edit/update/delete)
    #Think Backbone Model & View

    loop do
      view.print_menu
      case view.fetch_user_input.upcase
      when "S"
        board.start_game
        view.print_help_board
        while not board.is_solved? do
          view.print_board
          input = view.fetch_user_input
          case input
          when 1..9
            validMove = board.place_mark input
            if not validMove
              view.print_invalid_move
            end
          when "Q"
            puts "BYE!"
            exit
          else 
            view.print_help_board
          end
        end
        view.print_board
        view.print_solved
      when "Q"
        puts "We're done" 
        exit
      else
        view.print_error_message
      end
    end
  end
end

TTTController.new.run!