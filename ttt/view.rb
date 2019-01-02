module View
  module Print
    class << self
      def tell_user(message)
        puts message
      end

      def welcome
        tell_user "Welcome to Tic Tac Toe!"
      end

      def acceptable_moves
        tell_user "Please enter a unique number between 0-8."
      end

      def report_winner(currentTurn)
        tell_user "Game over. #{currentTurn} won."
      end

      def report_tie
        tell_user "Game over. Tied game."
      end

      def report_move(currentTurn, positionPlacement)
        tell_user "#{currentTurn}'s move: #{positionPlacement}"
      end
    end
  end
end
