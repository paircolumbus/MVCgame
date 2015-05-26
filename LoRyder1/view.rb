module GameView

	module Print
		class << self
			def run_spinner
				print "Loading (please wait) "
				3.times { print "."; sleep 1; }
				print "\n"
			end

			def error_message
				puts "That key will not work. Have another go!"
			end

			def title_screen
				title = <<-EOT
 				
 				=============================
 					You Bought A Zoo
 				=============================


				EOT
				puts title
			end

			def menagerie
				menagerie = <<-EOS

				=== Welcome=====

				- (A) View your animals
				- (B) Add a animal
				- (C) Export a animal
				- (D) Quit program

				========
				EOS

				puts menagerie
			end

			def print_zoo(animals)
				animals.each do |animal|
					puts "#{animal.id} || #{animal.name} - #{animal.description} - #{animal.weight}lbs"
				end
			end

			def serialize_animal
				{}.tap do |obj|
					["\nEnter the animal name:", "\nEnter the description:", "\nEnter the weight:"].each do |t|
						if obj.empty?
							obj[:name] = get_user_input(t)
						else
							obj[:description] = get_user_input(t)
						end
					end
				end
				
			end

			def deleted_id
				gimme_id = "\nEnter the id of the animal you want to sell"
				get_user_input(the_id)
			end

			def get_user_input(question=nil)
				puts question if question
				print "> "
				gets.chomp
			end
		end
	end
end