class Game
  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @com = "X" # the computer's marker
    @hum = "O" # the user's marker
  end

  def play_game
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} \n===+===+===\n #{@board[3]} | #{@board[4]} | #{@board[5]} \n===+===+===\n #{@board[6]} | #{@board[7]} | #{@board[8]} \n"
    puts "Enter [0-8]:"
    until winner || tie
      get_human_move
      if !winner && !tie
        get_computer_move
      end
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} \n===+===+===\n #{@board[3]} | #{@board[4]} | #{@board[5]} \n===+===+===\n #{@board[6]} | #{@board[7]} | #{@board[8]} \n"
    end
    puts winner ? "game over: winner" : "game over: tie"
  end

  def get_human_move
    space = nil
    until space
      space = gets.chomp.to_i
      space_available?(space) ? @board[space] = @hum : space = nil
    end
  end

  def get_computer_move
    space_available?(4) ? @board[4] = @com : @board[get_best_move] = @com
  end

  def space_available?(space)
    @board[space.to_i] != "X" && @board[space.to_i] != "O"
  end

  def get_best_move
    available_spaces = []
    get_available_spaces(available_spaces)
    best_move = nil
    available_spaces.each do |as|
      @board[as.to_i] = @com
      if winner
        best_move = as.to_i
        @board[as.to_i] = as
        return best_move
      else
        @board[as.to_i] = @hum
        if winner
          best_move = as.to_i
          @board[as.to_i] = as
          return best_move
        else
          @board[as.to_i] = as
        end
      end
    end
    get_random_move(available_spaces)
  end

  #receives board array, returns array of available spaces
  def get_available_spaces(available_spaces)
    @board.each do |space|
      if space_available?(space)
        available_spaces << space
      end
    end
    return available_spaces
  end

  #receives board array and best_move variable, returns boolean
  def winning_move
  end

  #receives board array and best_move variable, returns boolean
  def block_winning_move
  end

  def get_random_move(available_spaces)
    return available_spaces.sample.to_i
  end

  def winner
    [@board[0], @board[1], @board[2]].uniq.length == 1 ||
    [@board[3], @board[4], @board[5]].uniq.length == 1 ||
    [@board[6], @board[7], @board[8]].uniq.length == 1 ||
    [@board[0], @board[3], @board[6]].uniq.length == 1 ||
    [@board[1], @board[4], @board[7]].uniq.length == 1 ||
    [@board[2], @board[5], @board[8]].uniq.length == 1 ||
    [@board[0], @board[4], @board[8]].uniq.length == 1 ||
    [@board[2], @board[4], @board[6]].uniq.length == 1
  end

  def tie
    @board.all? { |space| space == "X" || space == "O" }
  end
end

game = Game.new
game.play_game
