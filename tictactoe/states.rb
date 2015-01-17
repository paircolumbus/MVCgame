require_relative "globals"

class GameState
  attr_writer :oldQuestion
  [:getBody, :send, :getQuestion].each do |i|
    define_method(i) do |*args|
      raise NotImplemented, "Please implement this function" 
    end
  end
  def invalidInput
    state = self.class.new
    state.oldQuestion = state.getQuestion
    def state.getQuestion
      ["Invalid input!"] + @oldQuestion 
    end
    state
  end
  def initialize
    @oldQuestion = []
  end
end

class InitState < GameState
  def getBody
    #["Some stuff is crazy", "and that is why I love it", "be peaceful my friend"]
    ["Welcome to Tic-Tac-Toe!", 
      'Type "newgame" to start a new two player game!', 
      'Type "quit" to return to bash']
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
    ["Please press enter to begin!"]
  end
end

class SetP1State < GameState
  def getBody
    ["Player 1 is currently: #{}"]
  end
  def send(input)
    case input.downcase
    when "newgame"
      setP1State.new
    when "quit"
      EndState.new
    else
      invalidInput
    end
  end
  def getQuestion
    ["Please enter a name for player 1"]
  end
end


class EndState < GameState

end