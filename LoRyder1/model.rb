require 'faker'

class Animal
	attr_reader :id, :name, :description, :weight, :dangerous

	def initialize args
		@id = args[:id]
		@name = args[:name]
		@description = args[:description]
		@weight = args[:weight]
		@dangerous = nil
	end
end

class Zoo
	attr_reader :animals

	def initialize
		@primary_id = 0
		@animals = []
		import_animals
	end

	def add_animal(input)
		@animals << Animal.new(input.merge(fetch_id))
	end

	def sell_animal(id)
		@animals.delete_if { |n| n.id == id}
	end

	def export_animal(id)
		@animals.delete_if { |n| n.id == id }
	end

	def import_animals
		add_animal(name: "Zebra", description: "part of the horse family with distinctive black and white stripes", weight: 700)
		add_animal(name: "Elephant", description: "large mammals, herbivores, and gray", weight: 15000)
		add_animal(name: "Lion", description: "big cat, male has mane, carnivore", weight: 440)
	end

	private

	def fetch_id
		{id: @primary_id +=1}
	end
end