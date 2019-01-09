require_relative "view"
require_relative "model"

class Controller
  include View

  def start_game
    game = Game.new
    Print::welcome
    Print::render_board(game)
    Print::acceptable_moves
    play(game)
  end

  def play(game)
    until game.check_game_over
      get_human_spot(game)
      # place_spot(current_turn, position_placement)
      game.move(game.current_turn, game.position_placement)
      game.switch_turns
      if !game.check_game_over
        # game.eval_board
      end
      Print::render_board(game)
    end
  end

  def get_human_spot(game)
    spot = nil
    until spot
      spot = gets.chomp
      if spot.to_i.to_s == spot && spot.to_i >= 0 && spot.to_i <= 8
        spot = spot.to_i
        # change this block by referring to position & current turn in model, spot this block to another method to be called in play
        if game.board[spot] != "X" && game.board[spot] != "O"
          game.board[spot] = "O"
        end
      else
        Print::acceptable_moves
        spot = nil
      end
    end
  end

  def place_move
  end

  def get_computer_move(game)
  end
end

Controller.new.start_game
