require_relative 'view'
require_relative 'models/Player'
require_relative 'Command'

class GameController
  include GameView

  def initialize
    @player = Player.new
  end

  def run!
    Print::title_screen

    Print::look_around_message @player

    loop do
      command = Print::fetch_command

      case command
      when ExitCommand
        Print::exit_message
        exit
      when HelpCommand
        Print::help_message
        next
      when UnknownCommand
        Print::idk_message
        next
      else
        command.run @player
        command = LookAroundCommand.new
      end

      if @player.won?
      	Print::win_message
      	exit
			end

      @player.do_environmental_effect
      @player.location.tick @player

      if @player.dead?
        Print::death_message @player
        exit
      end

      Print::look_around_message @player
    end
  end
end

GameController.new.run!
