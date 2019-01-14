require_relative "view"
require_relative "model"

class Controller
  include View

  def start_game
    game = Game.new
    Print::welcome
    handle_mode_setting(game)
    handle_difficulty_setting(game) if game.mode == game.HvC
    Print::report_settings(game)
    Print::render_board(game)
    play(game)
  end

  def handle_mode_setting(game)
    Print::tell_user("Choose game mode:\n[0] #{game.HvC} [1] #{game.HvH}, or [2] #{game.CvC}")
    mode = gets.chomp
    case mode
    when "0"
      game.set_mode(game.HvC)
    when "1"
      game.set_mode(game.HvH)
    when "2"
      game.set_mode(game.CvC)
    else
      Print::tell_user("Invalid input, please enter 0, 1 or 2")
      handle_mode_setting(game)
    end
  end

  def handle_difficulty_setting(game)
    Print::tell_user("Choose computer difficulty:\n[0] #{game.easy} or [1] #{game.hard}")
    difficulty = gets.chomp
    case difficulty
    when "0"
      game.set_difficulty(game.easy)
    when "1"
      game.set_difficulty(game.hard)
      # when "2"
      #   Print::tell_user("Difficulty: Impossible")
      #   game.set_difficulty(game.impossible)
    else
      Print::tell_user("Invalid input, please enter 0 or 1") #or 2
      handle_difficulty_setting(game)
    end
  end

  def play(game)
    until game.game_is_over
      if game.mode != game.CvC
        handle_human_move(game)
        Print::report_move(game.current_turn, game.space)
        Print::render_board(game)
        game.switch_turns if !game.game_is_over
      end
      if game.mode != game.HvH
        handle_computer_move(game) if !game.game_is_over
        game.switch_turns if !game.game_is_over
      end
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
