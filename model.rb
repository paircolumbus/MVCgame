require 'faker'
require 'pry'

class Todo
  attr_reader :id, :title, :description, :completed

  def initialize args 
    @id = args[:id] 
    @title = args[:title]
    @description = args[:description]
    @completed = false
  end

  def mark_completed
    @completed = true
  end

  def completed?
    @completed
  end
end

class List
  attr_reader :todos

  def initialize
    @primary_id = 0
    @todos = []
    populate_dummy_todos
  end

  def add_todo(input)
    @todos << Todo.new(input.merge(fetch_id))
  end

  def complete_todo(id)
    completed_item = @todos.select { |todo| todo.id == id }
    fail "No item matching that id" unless completed_item
    completed_item[0].mark_completed
  end

  def delete_todo(id)
    @todos.delete_if { |n| n.id == id }
  end

  def populate_dummy_todos
    5.times do
      add_todo(title: Faker::Lorem.word, description: Faker::Lorem.sentence) 
    end
  end

  private

  def fetch_id
    {id: @primary_id += 1 }
  end
end
