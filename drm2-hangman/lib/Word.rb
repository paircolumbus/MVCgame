class Word
  def initialize word
    @word = word.downcase
  end

  def has_letter? letter
    @word.include? letter.downcase
  end

  def get_letters
    @word.chars
  end

  def get_word
    @word
  end

  def get_lines guesses
    @word.chars.map{ |char|
      (guesses.include? char) ? char : '_'
    }.join
  end
end
