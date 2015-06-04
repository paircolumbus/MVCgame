class Die
  attr_reader :value

  def initialize
    @value = rand(6) + 1
  end
end

class DiceList
  include Enumerable
  attr_reader :id, :dice, :history

  def initialize
    @id = 0
    @dice = []
    @history = History.new
  end

  def each(&block)
    @dice.each(&block)
  end

  def roll!
    reset!
    5.times { @dice.push(Die.new); }
  end

  def reset!
    @history.add_roll(self)
    @dice = []
    @id += 1
  end

  def yahtzee?
    @dice.uniq.length == 1
  end

  def win!
    reset!
    die = Die.new
    5.times { @dice.push(die) }
  end

end

class History
  attr_reader :history

  def initialize
    @history = {}
  end

  def add_roll(dice_list)
    @history[dice_list.id] = dice_list.dice
  end

end
