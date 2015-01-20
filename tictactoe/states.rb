require_relative "globals"
require "pry"

class String
  def is_integer?
    self.to_i.to_s == self
  end
end

module GameState

  class State
    include GameModel
    attr_writer :oldQuestion, :errorMessage
    [:getBody, :send, :getQuestion].each do |i|
      define_method(i) do |*args|
        raise NotImplemented, "Please implement this function" 
      end
    end
    def invalidInput(error=nil)
      state = self.class.new
      error ? state.errorMessage = [error] : state.errorMessage = ["Invalid input!"]
      state.oldQuestion = state.getQuestion
      def state.getQuestion
        @errorMessage + @oldQuestion 
      end
      state
    end
    def initialize
      @oldQuestion = []
    end

    def commands(input)
      case input.downcase
      when ":newgame" || ":n"
        Model::initialize
        SetP1State.new
      when ":quit" || ":q"
        EndState.new
      when ":back" || ":b"
        Back.new
      else
        false
      end
    end
  end

  class InitState < State
    def getBody
      #["Some stuff is crazy", "and that is why I love it", "be peaceful my friend"]
      ["Welcome to Tic-Tac-Toe!", 
        'Available commands', 
        ':newgame => Start a new game',
        ':quit => Quit game']
    end
    def send(input)
      returned_value = commands(input) 
      return returned_value if returned_value
      invalidInput
    end
    def getQuestion
      ["Please press enter to begin!"]
    end
  end

  class SetP1State < State
    def getBody
      ["Player 1 is currently: #{Model::get_player(0)}",
        "Commands:", ":quit => Quit the application", ":back => Go to the previous menu"]
    end
    def send(input)
      returned_value = commands(input) 
      return returned_value if returned_value
      #set the name of the player and move to P2 selection state
      Model::set_player(input, 0)
      SetP2State.new
      #If game is playing, return to game
    end
    def getQuestion
      ["Please enter a name for player 1 and press enter!"]
    end
  end

  class SetP2State < State
    def getBody
      ["Player 2 is currently: #{Model::get_player(1)}",
        "Commands:", ":quit => Quit the application", ":back => Go to the previous menu"]
    end
    def send(input)
      returned_value = commands(input) 
      return returned_value if returned_value
      #set the name of the player and move to the next state
      Model::set_player(input, 1)

      #If game is playing, return to game

      P1Turn.new
    end
    def getQuestion
      ["Please enter a name for player 2"]
    end
  end


  class Turn < State

    def send(input, player)
      returned_value = commands(input) 
      return returned_value if returned_value

      coords = input.split("")

      return invalidInput("Please enter two numbers only") if coords.size != 2 

      if coords[0].is_integer? && coords[1].is_integer?
        coords.map!(&:to_i)
      else
        return invalidInput("Please only use numbers")
      end
      p coords 
      p Model::get_space(coords[0],coords[1])
      # binding.pry
      if Model::get_space(coords[0],coords[1])
        # binding.pry
        return invalidInput("There's already a piece on #{Model::get_space(coords[0],coords[1])}") 
      else
        Model::place_piece(player.piece.class.new(player), coords[0].to_i, coords[1].to_i)
        false
      end

    end
  end

  class P1Turn < Turn
    def getBody
      #Get board as text
      ["Player 1 turn!"] + Model::getBoardAsArray
    end

    def send(input)
      player = Model::get_player(0)

      returned_value = super(input, player)
      return returned_value if returned_value
      
      P2Turn.new
    end

    def getQuestion
      ["Place your #{Model::get_player(0).piece}! Ex: 00 => upper left"]
    end
  end

  class P2Turn < Turn
    def getBody
      ["Player 2 turn!"] + Model::getBoardAsArray
    end

    def send(input)
      player = Model::get_player(1)

      returned_value = super(input, player)
      return returned_value if returned_value

      P1Turn.new
    end

    def getQuestion
      ["Place your #{Model::get_player(1).piece}! Ex: 00 => upper left"]
    end
  end

  class Complete < State
    def getBody
      #["Some stuff is crazy", "and that is why I love it", "be peaceful my friend"]
      winning_position = Model::winning_position
      p winning_position
      rcd = ""

      if Model::winner
        case winning_position[0]
        when 0
          rcd = "Row"
        when 1
          rcd = "Col"
        when 2
          rcd = "diag"
        end
        ret = ["Congratulations player #{Model::winner}", "You won on #{rcd}#{winning_position[1]}",""]
      else 
        ret = ["No winner!",""]
      end
      
      ret += Model::getBoardAsArray
    end
    def send(input)
      returned_value = commands(input) 
      return returned_value if returned_value
        invalidInput
    end
    def getQuestion
      [""]
    end
  end

  class EndState < State

  end

  class Back < State

  end

end