class VoteCounter
  attr_reader :items

  # TODO explicit return -> turnary

  def initialize
    @items = []
  end

  def add_item(name)
    return false if @items.find { |x| x.name == name }
    @items << Item.new(name)
  end

  def vote_for(name)
    return false unless (item = @items.find { |x| x.name == name })
    item.vote
  end

  def winning_items
    max_votes = @items.map { |y| y.votes }.sort.last
    @items.select { |x| x.votes == max_votes }
  end

  def delete(item)
    @items.reject! { |x| x.name == item }
  end
end

class Item
  attr_reader :votes, :name

  def initialize(name)
    @name = name
    @votes = 0
  end

  def vote
    @votes += 1
  end
end
