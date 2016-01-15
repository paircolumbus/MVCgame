require 'faker'
require 'pry'

class Action
  attr_reader :id, :title
   def initialize(id, title)
    @id = id
    @title = title
  end
end

class List
  attr_reader :actions

  def initialize
    @actions = []
    populate_actions
  end

  def reset
    @actions = []
    populate_actions
  end

  private

  def populate_actions
    id = 1;
    3.times do
      new_action = generate_action()
      @actions << Action.new(id, new_action)
      id += 1
    end
  end

  def generate_action()
    titles = ["Meander left.", "Climb cliff.", "Cross stream.",
     "Sprint in random direction.", "Fight your way past menacing bear.",
     "Traverse right.", "Crawl forward."]
     ra = Random.new
     new_title = titles[ra.rand(0...titles.length)]
  end
end
