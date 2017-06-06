class DeafGrandma
	attr_reader :age, :name
	attr_accessor :asleep, :sleep_count

	def initialize(name)
		@name = name
		@age = 100
		@asleep = false
		@sleep_count = 0
	end

	def converse(input)

		if input.upcase == input
			if @asleep
				@sleep_count += 1
				if @sleep_count == 3
					@asleep = false
					@sleep_count = 0
					puts "*Grandma " + @name + " jolts awake!*"
					puts "OH HI THERE SONNY!"
				else
					puts "*Grandma " + @name + " moves slightly in her sleep*"
				end
			elsif input == "EAT, GRANDMA!"
				puts "MMMM PORIDGE!"
				puts "*snores*"
				@asleep = true
			elsif input == "HOW OLD ARE YOU?"
				puts "I'M 100 YEARS OLD SONNY!"
			elsif input == "BYE"
				puts "SEE YOU SONNY!"
				exit
			else
				puts "NOT SINCE 1964!"
			end
		else
			if @asleep
				puts "*Grandma " + @name + " snores loudly*"
			else
				puts "WHAT WAS THAT SONNY?"
			end
		end
	end
end

