require 'faker'
require 'pry'

class Bottle
  attr_reader :id, :title, :description, :completed

  def initialize args
    @id = args[:id]
    @title = args[:title]
    @description = args[:description]
  end
end

class Wall
  attr_reader :bottles

  def initialize
    @primary_id = 0
    @bottles = []
    populate_dummy_bottles
  end

  def add_bottle(input)
    @bottles << Bottle.new(input.merge(fetch_id))
  end

  def drink_bottle(bottleId, drinker)
    @bottles.delete_if { |n| n.id == bottleId }
    drinker.drink()
  end

  def populate_dummy_bottles
    5.times do
      add_bottle(title: Faker::Lorem.word, description: Faker::Lorem.sentence)
    end
  end

  def empty?
    @bottles.count == 0
  end

  private

  def fetch_id
    {id: @primary_id += 1 }
  end
end

class Drinker
  attr_reader :intoxication

  def initialize
    @intoxication = 0
  end

  def drink
    @intoxication += 1
  end

  def drunk?
    @intoxication > 3
  end
end
