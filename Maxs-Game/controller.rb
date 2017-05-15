require_relative './model'
require_relative './view'


class Controller

  def initialize
    @view = View.new
    @model = Model.new
    run
  end

  def run
    until @model.byeCounts >= 3 do
      saidByUser = @view.speakToGma
      output = handleUserInput(saidByUser)
      @view.gmaSpeaks(output)
    end
    @view.gameEnds
  end

  def handleUserInput(phrase)

    if phrase.upcase == phrase
      outphrase = 'NOT SINCE 1967'
      if phrase == 'BYE'
        @model.incrementByeCount
        outphrase = 'OK, SEEYA SONNY!'
      end
      outphrase
    else
      'SPEAK UP SONNY!'
    end
  end

end

Controller.new
