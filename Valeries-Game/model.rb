class Pet
	attr_accessor :petName, :petType, :nutrition, :hydration, :socialization, :cleanliness, :energy

	def initialize args
		@petName = args[:petName]
		@petType = args[:petType]
		@nutrition = 15
		@hydration = 15
		@socialization = 15
		@cleanliness = 15
		@energy = 15
	end

	def feed
		@nutrition += 3
		@hydration -= 1 
		@cleanliness -= 1
		@energy -= 1 
	end

	def provide_water
		@hydration += 3
		@cleanliness -= 1
	end

	def play
		@nutrition -= 1
		@hydration -= 1
		@socialization += 3
		@energy -= 1
	end

	def clean_waste 
		@socialization -= 1
		@cleanliness += 3
	end

	def tuck_in
		@nutrition -= 1 
		@hydration -= 1 
		@socialization -= 1
		@energy += 4
	end
end
