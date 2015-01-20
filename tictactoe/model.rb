require_relative 'globals'

module GameModel

  module Model

    class << self
      attr_reader :board
      attr_accessor :winner, :winning_position
      @initilized = false

      def initialize()
        @players = [nil, nil]
        @board = Board.new()
        @initilized = true
        @winner = nil
      end

      def set_player(name, p)
        @players[p] = Player.new(name, p == 0 ? X.new(self) : O.new(self))
      end
      
      def get_player(i)
        @players[i] ? @players[i] : "not set"
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
        puts string
        string
      end

      def place_piece(piece, r, c)
        @board.data[r][c] = piece
      end

      def get_space(r,c)
        @board.data[r][c]
      end

    end
  end

  class Player
    attr_reader :piece
    def initialize(name, piece)
      @name = name
      @piece = piece
    end

    def to_s
      @name + "(" + @piece.to_s + ")"
    end
  end

  class Piece
    attr_reader :owner
    def initialize(owner)
      @owner = owner
    end
  end

  class X < Piece
    def to_s
      "X"
    end
  end

  class O < Piece
    def to_s
      "O"
    end
  end

  class Board
    attr_accessor :data, :size
    def initialize(size=3)
      @size = size
      # @data = [[X.new(P1.new("Mike")),nil,nil],[X.new(P1.new("Mike")),X.new(P1.new("Mike")),nil],[X.new(P1.new("Mike")),nil,X.new(P1.new("Mike"))]]#Array.new(size) { Array.new(size) { nil }}#X.new(P2.new("Mike")) } }
      @data = Array.new(size) { Array.new(size) { nil } }
    end

    def full?
      @data.flatten.reduce(true) { |m, i| m && i }
    end
  end
end
