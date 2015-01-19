require_relative 'globals'

module GameModel

  module Model

    class << self

      @initilized = false

      def initialize()
        @p1 = nil
        @p2 = nil
        @board = Board.new()
        @initilized = true
      end

      def setp1(name)

      end

      def setp2(name)

      end

      def getp1()

      end

      def getp2()

      end

      def getBoardAsArray
        string = ["    \e[4m [0]   [1]   [2] \e[0m   "]
        @board.size.times do |r|
          row = "[#{r}] |"
          @board.size.times do |c|
            row += "\e[4m  " + (@board.data[r][c] ? @board.data[r][c].to_s : " ") + "  \e[0m|"
          end
          row += "   "
          string.push(row)
        end
        string
      end

    end
  end

  class Player

  end

  class P1 < Player

  end

  class P2 < Player

  end

  class Piece
    attr_reader :owner
    def initialize(owner)
      @owner = owner
    end
  end

  class X < Piece
    def to_str
      "X"
    end
  end

  class O < Piece
    def to_str
      "O"
    end
  end

  class Board
    attr_accessor :data, :size
    def initialize(size=3)
      @size = size
      @data = Array.new(size) { Array.new(size) { |i| i*2 } }
    end

  end
end
