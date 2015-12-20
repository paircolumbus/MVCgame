class View


  def initialize
  end

  def speakToGma
    puts 'What do you say to GMa? > '
    gets.chomp
  end

  def gmaSpeaks(phrase)
    puts phrase
  end

  def gameEnds
    puts 'Game Over'
    exit
  end

end
