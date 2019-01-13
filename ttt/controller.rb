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
      handle_human_move(game)
      game.switch_turns if !game.game_is_over
      puts "switching turns after human"
      handle_computer_move(game) if !game.game_is_over
      game.switch_turns if !game.game_is_over
      puts "switching turns after computer"
    end
    handle_game_over(game)
  end

  def handle_human_move(game)
    Print::acceptable_moves
    space = gets.chomp
    game.valid_move(space) ? game.move(space.to_i) : handle_human_move(game)
    Print::report_move(game.current_turn, game.space)
    Print::render_board(game)
  end

  def handle_computer_move(game)
    game.get_computer_move
    Print::report_move(game.current_turn, game.space)
    Print::render_board(game)
  end

  def handle_game_over(game)
    game.winner ? Print::report_winner(game.current_turn) : Print::report_tie
  end
end

Controller.new.start_game
