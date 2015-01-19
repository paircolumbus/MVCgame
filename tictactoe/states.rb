require_relative "globals"

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
  end

  class InitState < State
    def getBody
      #["Some stuff is crazy", "and that is why I love it", "be peaceful my friend"]
      ["Welcome to Tic-Tac-Toe!", 
        'Type "newgame" to start a new two player game!', 
        'Type "quit" to return to bash']
    end
    def send(input)
      case input.downcase
      when "newgame"
        Model::initialize
        SetP1State.new
      when "quit"
        EndState.new
      else
        invalidInput
      end
    end
    def getQuestion
      ["Please press enter to begin!"]
    end
  end

  class SetP1State < State
    def getBody
      ["Player 1 is currently: #{}",
        "Commands:", ":quit => Quit the application", ":back => Go to the previous menu"]
    end
    def send(input)
      case input.downcase
      when ":back"
        setP1State.new
      when ":quit"
        EndState.new
      else
        #set the name of the player and move to P2 selection state

        #If game is playing, return to game

        SetP2State.new
      end
    end
    def getQuestion
      ["Please enter a name for player 1"]
    end
  end

  class SetP2State < State
    def getBody
      ["Player 2 is currently: #{}",
        "Commands:", ":quit => Quit the application", ":back => Go to the previous menu"]
    end
    def send(input)
      case input.downcase
      when ":back"
        setP1State.new
      when ":quit"
        EndState.new
      else
        #set the name of the player and move to the next state


        #If game is playing, return to game

        P1Turn.new
      end
    end
    def getQuestion
      ["Please enter a name for player 2"]
    end
  end

  class Turn < State

  end

  class P1Turn < Turn
    def getBody
      #Get board as text
      Model::getBoardAsArray
    end
    def send(input)
      case input.downcase
      when ":back"
        setP1State.new
      when ":quit"
        EndState.new
      else
        #Check to ensure space is empty

        #Check for endgame conditions

        #Move to proper state

        P2Turn.new
      end
    end
    def getQuestion
      [""]
    end
  end

  class P2Turn < Turn
    def getBody
      [""]
    end
    def send(input)
      case input.downcase
      when ":back"
        setP1State.new
      when ":quit"
        EndState.new
      else
        #Check to ensure space is empty

        #Check for endgame conditions

        #Move to proper state

        Complete.new
      end
    end
    def getQuestion
      [""]
    end
  end

  class Complete < State
    def getBody
      #["Some stuff is crazy", "and that is why I love it", "be peaceful my friend"]
      ["Congratulations player #{}"]
    end
    def send(input)
      case input.downcase
      when "newgame"
        SetP1State.new
      when "quit"
        EndState.new
      else
        invalidInput
      end
    end
    def getQuestion
      [""]
    end
  end

  class EndState < State

  end

end