module View
  module Print
    class << self
      def tell_user(message)
        puts message
      end

      def welcome
        tell_user "Welcome to Tic Tac Toe!"
      end

      def render_board(game)
        Print::tell_user(
          " #{game.board[0]} | #{game.board[1]} | #{game.board[2]} \n===+===+===\n #{game.board[3]} | #{game.board[4]} | #{game.board[5]} \n===+===+===\n #{game.board[6]} | #{game.board[7]} | #{game.board[8]} \n\n"
        )
      end

      def report_settings(game)
        tell_user "*******************************"
        tell_user "Game Settings:\nMode: #{game.mode}\n"
        tell_user "Difficulty: #{game.difficulty}" if game.mode != game.HvH
        tell_user "*******************************"
      end

      def acceptable_moves
        tell_user "Please enter a unique number between 0-8."
      end

      def report_winner(current_turn)
        tell_user "Game over. #{current_turn} won."
      end

      def report_tie
        tell_user "Game over. Tied game."
      end

      def report_move(current_turn, space)
        tell_user "#{current_turn}'s move: #{space}"
      end
    end
  end
end
