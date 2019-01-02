require_relative "view"
require_relative "model"

class Controller
  include View

  def start_game
    game = Game.new
    Print::welcome
    render_board(game)
    Print::acceptable_moves
  end

  def render_board(game)
    Print::tell_user(
      " #{game.board[0]} | #{game.board[1]} | #{game.board[2]} \n===+===+===\n #{game.board[3]} | #{game.board[4]} | #{game.board[5]} \n===+===+===\n #{game.board[6]} | #{game.board[7]} | #{game.board[8]} \n"
    )
  end
end

Controller.new.start_game
