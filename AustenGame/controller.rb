require_relative 'view'
require_relative 'model'

class GameController
  include GameView
  attr_reader :winning_sequence, :user_actions

  def initialize
    @winning_sequence = []
    @user_actions = []
  end

  def run!
    ra = Random.new
    3.times do
      winning_sequence << ra.rand(1..3)
    end
    action_list = List.new
    Print::title_screen

    loop do
      action_list.reset
      Print::menu
      Print::print_list(action_list.actions)
      case Print::fetch_user_input
      when "1"
        add_user_action(1)
        check_for_win
        Print::select_option(1, action_list.actions)
      when "2"
        add_user_action(2)
        check_for_win
        Print::select_option(2, action_list.actions)
      when "3"
        add_user_action(3)
        check_for_win
        Print::select_option(3, action_list.actions)
      when "Q"
        puts "You lost your taste for adventure" 
        exit
      else
        Print::error_message
      end
    end
  end

  private
  def add_user_action(option)
    if user_actions.length > 2
      user_actions.shift
    end
    user_actions.push(option)
  end

  def check_for_win
    if user_actions == winning_sequence
      Print::win
      exit
    end
  end
end

GameController.new.run!
