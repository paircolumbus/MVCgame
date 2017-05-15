require_relative 'view'
require_relative 'model'

class GameController
  include GameView

  def run!
    scorekeeper = Scorekeeper.new
    Print::title_screen

    loop do
      Print::score(scorekeeper.player_score, scorekeeper.computer_score)
      case Print::new_match
      when "r", "R"
        scorekeeper.evaluate(:rock)
      when "p", "P"
        scorekeeper.evaluate(:paper)
      when "s", "S"
        scorekeeper.evaluate(:scissors)
      else
        Print::error_message
      end
      Print::matchup(scorekeeper.player_move.to_s.upcase, scorekeeper.computer_move.to_s.upcase)
      if scorekeeper.win == true
        Print::winning_message
      elsif scorekeeper.win == false
        Print::losing_message
      else
        Print::tie_message
      end
    end
  end
end

GameController.new.run!