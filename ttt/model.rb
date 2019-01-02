class Game
  attr_reader :board

  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @X = "X"
    @O = "O"
  end
end
