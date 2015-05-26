class VoteCounter
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item!(name)
    @items << Item.new(name)
  end

  def winning_items
    max_votes = @items.map { |y| y.votes }.sort.last
    winners = @items.select { |x| x.votes == max_votes }

    winners
  end

  def delete!(item)
    return false if @items.none? { |x| x.name == item }
    @items.delete_if { |x| x.name == item }
  end
end

class Item
  attr_reader :votes, :name

  def initialize(name)
    @name = name
    @votes = 0
  end

  def vote!
    @votes += 1
  end
end
