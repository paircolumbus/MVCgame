require_relative "view"
require_relative "model"

class Controller
  include View

  def start_game
    game = Game.new
    Print::welcome

    difficulty_setting(game)
    Print::render_board(game)
    play(game)
  end

  def difficulty_setting(game)
    Print::tell_user("Choose computer difficulty: [0] Easy or [1] Hard")
    difficulty = gets.chomp
    case difficulty
    when "0"
      Print::tell_user("Difficulty: Easy")
      game.set_difficulty("Easy")
    when "1"
      Print::tell_user("Difficulty: Hard")
      game.set_difficulty("Hard")
      # when "2"
      #   Print::tell_user("Difficulty: Impossible")
      #   game.set_difficulty("Impossible")
    else
      Print::tell_user("Invalid input, please enter 0 or 1") #or 2
      difficulty_setting(game)
    end
  end

  def play(game)
    until game.game_is_over
      handle_human_move(game)
      Print::report_move(game.current_turn, game.space)
      Print::render_board(game)
      game.switch_turns if !game.game_is_over
      handle_computer_move(game) if !game.game_is_over
      game.switch_turns if !game.game_is_over
    end
    handle_game_over(game)
  end

  def handle_human_move(game)
    Print::acceptable_moves
    space = gets.chomp
    valid_move(space, game) ? game.move(space.to_i) : handle_human_move(game)
  end

  def valid_move(space, game)
    int = space.to_i
    int.to_s == space &&
    int >= 0 &&
    int <= 8 &&
    game.board[int] != game.X &&
    game.board[int] != game.O ?
      true : false
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
