require_relative "view"
require_relative "model"

class Controller
  include View

  def start_game
    game = Game.new
    Print::welcome
    Print::render_board(game)
    play(game)
  end

  def play(game)
    until game.game_is_over
      # game.get_best_move(game)
      handle_human_move(game)
      Print::report_move(game.current_turn, game.spot)
      game.switch_turns if !game.game_is_over
      handle_computer_move(game) if !game.game_is_over
      game.switch_turns if !game.game_is_over
      Print::render_board(game)
    end
    handle_game_over(game)
  end

  def handle_human_move(game)
    Print::acceptable_moves
    spot = gets.chomp
    valid_move(spot, game) ? game.move(spot) : handle_human_move(game)
  end

  def valid_move(spot, game)
    int = spot.to_i
    int.to_s == spot &&
    int >= 0 && int <= 8 &&
    game.board[int] != game.X &&
    game.board[int] != game.O ?
      true : false
  end

  def handle_computer_move(game)
    game.eval_board
  end

  def handle_game_over(game)
    game.winner(game.board) ? Print::report_winner(game.current_turn) : Print::report_tie
  end
end

Controller.new.start_game
