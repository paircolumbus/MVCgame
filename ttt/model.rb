class Game
  attr_reader :board, :X, :O
  attr_accessor :current_turn, :position_placement

  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @X = "X" #computer/second
    @O = "O" #human/first
    @current_turn = @O
    @position_placement
  end

  def switch_turns
    @current_turn = @current_turn == @X ? @O : @X
  end

  def position_placement
    @position_placement = 4
  end

  def move(current_turn, position_placement)
    puts "#{current_turn} moves to #{position_placement}"
  end

  def eval_board
    spot = nil
    until spot
      if @board[4] == "4"
        spot = 4
        @board[spot] = @X
      else
        spot = get_best_move(@board, @X)
        if @board[spot] != "X" && @board[spot] != "O"
          @board[spot] = @X
        else
          spot = nil
        end
      end
    end
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    available_spaces = []
    best_move = nil
    board.each do |s|
      if s != "X" && s != "O"
        available_spaces << s
      end
    end
    available_spaces.each do |as|
      board[as.to_i] = @X
      if check_game_over
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = "O"
        if check_game_over
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

  def check_game_over
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
    board.all? { |s| s == "X" || s == "O" }
  end
end
