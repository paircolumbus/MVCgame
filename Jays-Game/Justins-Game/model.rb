class Todo
  attr_reader :id, :name, :description, :completed

  def initialize(args)
    @id = args[:id]
    @name = args[:name]
    @description = args[:description]
    @completed = false
  end

  def complete
    @completed = true
  end

  def completed?
    @completed
  end
end

class List
  attr_reader :todos

  def initialize
    @pid = 0
    @todos = []
  end

  def add_todo(input)
    @todos << Todo.new(input.merge(find_id))
  end

  def complete_todo(id)
    completed_item = @todos.select{ |todo| todo.id == id }
    unless completed_item
      fail "Cannot find todo with id of #{id}"
    end
  end

  def delete_todo(id)
    @todos.delete_if{ |n| n.id == id }
  end

  private
  def find_id
    {id: @pid += 1}
  end
end
