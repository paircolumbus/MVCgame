require_relative 'globals'



class GameController
  include GameView
  include GameState

  def run!
    # Print::display("Mikes page!" , ["Some stuff is crazy", "and that is why I love it", "be peaceful my friend"], "~Kenworthy", 80)
    @currState = InitState.new

    until @currState.is_a? EndState do
      Print::initialize("Hello world!", "~Kenworthy inc", 80)
      Print::display(@currState.getBody)

      @currState = @currState.send(Print::getInput(@currState.getQuestion))

    end

  end

end

GameController.new.run!
