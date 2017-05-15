class Game
  attr_reader :move_list, :grid
  
  def initialize
    @move_list = []
    @grid = [[nil, nil, nil],[nil, nil, nil],[nil, nil, nil]]
  end

  def register(move)
    x = move.loc[:x]
    y = move.loc[:y]
    @grid[x][y] = move.symbol

    @move_list << move
  end

  def winner?
    result = false
    # check rows, columns for winner
    for i in 0..2
      result ||= (@grid[i][0] == @grid[i][1] && @grid[i][1] == @grid[i][2] && @grid[i][2])
      result ||= (@grid[0][i] == @grid[1][i] && @grid[1][i] == @grid[2][i] && @grid[2][i])
    end
    # check diagonals for winner
    result ||= (@grid[0][0] == @grid[1][1] && @grid[1][1] == @grid[2][2] && @grid[2][2])
    result ||= (@grid[0][2] == @grid[1][1] && @grid[1][1] == @grid[2][0] && @grid[2][0])

    # check for tie
    # interesting project: better tie-detecting method
    result ||= @move_list.count >= 9
  end

end

class Move
  attr_reader :symbol, :loc
  @@count = 0

  def initialize(location)
    @@count += 1
    @id = @@count
    @loc = location
    @symbol = @id.even? ? "O" : "X"
  end
end
