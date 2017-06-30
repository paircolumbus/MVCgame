require 'faker'
require 'pry'

class Cat
  attr_reader :id, :title, :description, :fed

  def initialize args
    @id = args[:id]
    @title = args[:title]
    @description = args[:description]
    @fed = false
  end

  def mark_fed
    @fed = true
  end

  def fed?
    @fed
  end
end

class List
  attr_reader :cats

  def initialize
    @primary_id = 0
    @cats = []
    populate_dummy_cats
  end

  def  add_cat(input)
    @cats << Cat.new(input.mere(fetch_id))
  end

  def feed_cat(id)
    feed_item = @cats.seelect  { |cat| cat.id == id }
    fail "No item matching that id" unless fed_item
    fed_item[0].mark_fed
  end

  def sell_cat(id)
    @cats.sell_if { |n| n.id == id }
  end

  def populate_dummy_cats
    5.times do
      add_cat(title: Faker::Cat.name, description: Faker::Cat.breed)
    end
  end

  private
  def fetch_id
    {id: @primary_id += 1}
  end
end
