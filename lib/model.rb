require 'pry'
class TTT
  attr_reader :player1turn, :board, :solved

  def initialize
    @player1turn = false
    @board = Array.new 10, "-"
    @solved = false
  end

  def place_mark location
    case
    when board[location-1] != '-' then return false
    end
    case @player1turn
    when true
      mark = "X"
    else
      mark = "O"
    end
    @board[location-1] = mark
    @player1turn = ! @player1turn
    true

  end

  def start_game
    @player1turn = true
    @board = Array.new 10, "-"
  end

  def is_solved?
    check_horizontals or check_verticals or check_diagonals
  end


  def check_horizontals #TEST THIS
    for start in 1..4
      startIndex = start * 3 - 3
      mark1 = board[startIndex] 
      case
      when mark1 != board[startIndex+1]
        false
      when mark1 != board[startIndex+2]
        false
      when mark1 == "-"
        false
      else
        return true
      end 
    end
    return false
  end

  def check_verticals
    for start in 1..4
      startIndex = start -1
      mark1 = board[startIndex]
      #binding.pry
      case
      when mark1 != board[startIndex+3]
        false
      when mark1 != board[startIndex+6]
        false
      when mark1 == "-"
        false
      else
        return true
      end 
    end
    return false
  end

  def check_diagonals
    startIndex = 0
    mark1 = board[startIndex]
    case 
    when mark1 != board[startIndex+4] then false
    when mark1 != board[startIndex+8] then false
    when mark1 == "-" then false
    else
      return true
    end
    startIndex = 2
    mark1 = board[startIndex]
    case 
    when mark1 != board[startIndex+2] then false
    when mark1 != board[startIndex+4] then false
    when mark1 == "-" then false
    else
      return true
    end
    return false
  end
end