class TTTView
  attr_reader :game

  def initialize newGame=TTT.new
    @game = newGame
  end

  def print_title
title = <<TITLE

     ********** || **********
     *     Tic Tac Toe      *
     ********** || **********

TITLE
     puts title
   end

  def print_menu
    menu = <<MENU
      Prepare yourself for 
    the ultimate tic-tac-toe 
          experience
    (S)tart a new game
    (Q)uit

MENU
    puts menu
  end

  def print_invalid_move
    puts "ERROR... Space already filled"
  end

  def print_solved
    case game.player1turn
    when true
      puts "Player 0 Wins!"
    when false
      puts "Player X Wins!"
    end
  end

  def fetch_user_input(question=nil)
    puts question if question
    print "> "
    output = gets.chomp
    if output.to_i != 0
      output.to_i
    else
      output.upcase
    end
  end

  def print_error_message
    puts "Type what's in the ()"
  end

  def print_help_board
    help_board = <<help_board
    -----------------------------------
Input the location that you want to place a mark
1\#2\#3
\#\#\#\#\#
4\#5\#6
\#\#\#\#\#
7\#8\#9
To bring this up again type 'h'
    -----------------------------------
help_board
    puts help_board
    help_board
  end

  def print_board
    line = ""
    linenum = 1
    lm1 = @game.board[(3 * linenum)-3]
    lm2 = @game.board[(3 * linenum)-2]
    lm3 = @game.board[(3 * linenum)-1]
    line += "#{lm1}\##{lm2}\##{lm3}"
    for linenum in 2..3
      lm1 = @game.board[(3 * linenum)-3]
      lm2 = @game.board[(3 * linenum)-2]
      lm3 = @game.board[(3 * linenum)-1]
      line += "\n\#\#\#\#\#"
      line += "\n#{lm1}\##{lm2}\##{lm3}"
    end
    puts line
    line
    puts "    -----------------------------------"
  end

end