require_relative 'view'
require_relative 'model'

class GameController
  include GameView

  def run!
    dice = DiceList.new

    Print::title_screen

    loop do
      Print::menu
      case Print::fetch_user_input
      when "R"
        dice.roll!
        dice.each { |die| Print::print_die(die.value) }
        Print::did_i_win(dice.yahtzee?)
      # when "X"
      #   dice.reset!
    when "r"
        dice.win!
        dice.each { |die| Print::print_die(die.value) }
        Print::did_i_win(dice.yahtzee?)
      when "Q"
        puts "You chose to exit"
        exit
      else
        Print::error_message
      end
    end
  end
end

GameController.new.run!
