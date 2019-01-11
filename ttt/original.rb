class Game
  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @com = "X" # the computer's marker
    @hum = "O" # the user's marker
  end

  def start_game
    # start by printing the board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} \n===+===+===\n #{@board[3]} | #{@board[4]} | #{@board[5]} \n===+===+===\n #{@board[6]} | #{@board[7]} | #{@board[8]} \n"
    puts "Enter [0-8]:"
    # loop through until the game was won or tied
    until game_is_over(@board) || tie(@board)
      get_human_spot
      if !game_is_over(@board) && !tie(@board)
        eval_board
      end
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} \n===+===+===\n #{@board[3]} | #{@board[4]} | #{@board[5]} \n===+===+===\n #{@board[6]} | #{@board[7]} | #{@board[8]} \n"
    end
    puts "Game over"
  end

  def get_human_spot
    spot = nil
    until spot
      spot = gets.chomp.to_i
      # puts spot >= 0 && spot <= 8 ? "valid input" : "invalid input"
      if @board[spot] != "X" && @board[spot] != "O"
        @board[spot] = @hum
      else
        # puts "unacceptable input"
        spot = nil
      end
    end
  end

  def eval_board
    spot = nil
    until spot
      if @board[4] == "4"
        spot = 4
        @board[spot] = @com
      else
        spot = get_best_move(@board, @com)
        if @board[spot] != "X" && @board[spot] != "O"
          @board[spot] = @com
        else
          spot = nil
        end
      end
    end
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    available_spaces = []
    get_available_spaces(available_spaces)
    best_move = nil
    available_spaces.each do |as|
      board[as.to_i] = @com
      if game_is_over(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @hum
        if game_is_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
        end
      end
    end
    best_move ? best_move : get_random_move(board)
  end

  #receives board array, returns array of available spaces
  def get_available_spaces(available_spaces)
    @board.each do |space|
      if space != "X" && space != "O"
        available_spaces << space
      end
    end
    puts "available_spaces: #{available_spaces}"
    return available_spaces
  end

  #receives board array and best_move variable, returns boolean
  def winning_move(board, best_move)
  end

  #receives board array and best_move variable, returns boolean
  def block_winning_move(board, best)
  end

  def get_random_move(available_spaces)
    return available_spaces.sample.to_i
  end

  def game_is_over(b)
    [b[0], b[1], b[2]].uniq.length == 1 ||
    [b[3], b[4], b[5]].uniq.length == 1 ||
    [b[6], b[7], b[8]].uniq.length == 1 ||
    [b[0], b[3], b[6]].uniq.length == 1 ||
    [b[1], b[4], b[7]].uniq.length == 1 ||
    [b[2], b[5], b[8]].uniq.length == 1 ||
    [b[0], b[4], b[8]].uniq.length == 1 ||
    [b[2], b[4], b[6]].uniq.length == 1
  end

  def tie(b)
    b.all? { |space| space == "X" || space == "O" }
  end
end

game = Game.new
game.start_game
