class Game
  attr_reader :board, :X, :O
  attr_accessor :symbol, :current_turn, :spot

  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @X = "X"
    @O = "O"
    @center = "4"
    @symbol
    @current_turn = @O
    @spot
  end

  def switch_turns
    @current_turn = @current_turn == @X ? @O : @X
  end

  def move(spot)
    @spot = spot
    @board[spot] = @current_turn
  end

  def eval_board
    if @board[4] == @center
      @board[4] = @current_turn
    else
      spot = get_best_move(@board)
      @board[spot] = @current_turn
    end
  end

  def get_best_move(board)
    available_spaces = []
    best_move = nil
    board.each do |s|
      if s != @X && s != @O
        available_spaces << s
      end
    end
    available_spaces.each do |as|
      board[as.to_i] = @current_turn
      if game_is_over
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @O
        if game_is_over
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
        end
      end
    end
    if best_move
      return best_move
    else
      n = rand(0..available_spaces.count)
      return available_spaces[n].to_i
    end
  end

  def game_is_over
    winner(@board) || tie(@board) ? true : false
  end

  def winner(board)
    [board[0], board[1], board[2]].uniq.length == 1 ||
    [board[3], board[4], board[5]].uniq.length == 1 ||
    [board[6], board[7], board[8]].uniq.length == 1 ||
    [board[0], board[3], board[6]].uniq.length == 1 ||
    [board[1], board[4], board[7]].uniq.length == 1 ||
    [board[2], board[5], board[8]].uniq.length == 1 ||
    [board[0], board[4], board[8]].uniq.length == 1 ||
    [board[2], board[4], board[6]].uniq.length == 1
  end

  def tie(board)
    board.all? { |s| s == @X || s == @O }
  end
end
