require_relative 'view'
require_relative 'model'

class Control
	include GameView

	def run!
		Print::title_screen

		loop do
		  Print::menu
          case Print::get_input
          when "1"
          	name = get_input("What's your Grandma's name?")
          	talk_to_gma(name)
          when "2"
          	Print::show_instructions
          when "3"
          	exit
          else
          	Print::error_message
          end
		end
	end

	def talk_to_gma(name)
		grandma = DeafGrandma.new(name)
		loop do
			phrase = get_input("Say something to Grandma:")
			grandma.converse(phrase)
		end
	end

	def get_input(prompt=nil)
    	puts prompt if prompt
    	print "> "
    	gets.chomp
      end
end

Control.new.run!
