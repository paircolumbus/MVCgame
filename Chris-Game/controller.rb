require_relative 'model'
require_relative 'view'

class DeafGrandmaController
	include DeafGrandmaView

	def run
		Print::title

		loop do		
			Print::main_menu
			case Print::get_user_input
			when"N"
				play_game
			when"T"
				Print::tutorial
			when "E"
				Print::bye
				exit	
			else
				Print::error
			end			
		end
	end

	def play_game
		Print::game 'HOWDY SONNY!'		
		loop do
			input = Print::get_user_input
			if (input == 'BYE!') then
				return
			elsif (input != input.upcase) then
				Print::game 'SPEAK UP SONNY!'		
			else
				# Print a random message from the model.
				Print::game DeafGrandmaModel::SENTENCES.sample.upcase
			end
		end
	end
end

DeafGrandmaController.new.run
