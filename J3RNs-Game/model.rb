class VoteCounter
  attr_reader :items

  def initialize
    @items = []
  end

  # Add item if it does not already exist
  def add_item(name)
    @items.find { |x| x.name == name } ? false : @items << Item.new(name)
  end

  # Vote for item if item exists
  def vote_for(name)
    (item = @items.find { |x| x.name == name }) ? item.vote : false
  end

  # Get an array of items sharing the highest number of votes
  def winning_items
    max_votes = @items.map { |y| y.votes }.sort.last
    @items.select { |x| x.votes == max_votes }
  end

  # Delete item from list
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

  # Votes++
  def vote
    @votes += 1
  end
end
