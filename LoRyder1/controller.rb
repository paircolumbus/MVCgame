require_relative 'view'
require_relative 'model'

class GameController
	include GameView

	def run!
		animalsZoo = Zoo.new

		Print::run_spinner
		Print::title_screen

		loop do
			Print::menagerie
			case Print::get_user_input
			when "A"
				Print::print_zoo(animalsZoo.animals)
			when "B"
				animalsZoo.add_animal(Print::serialize_animal)
			when "C"
				animalsZoo.export_animal(Print::deleted_id.to_i)
			when "D"
				puts "Thanks for visiting the Zoo"
				exit
			else
				Print::error_message
			end
		end
	end
end

GameController.new.run!
