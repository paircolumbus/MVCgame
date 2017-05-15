require_relative 'Word'
require 'random-word'

class WordFactory
  # return a random word or phrase
  def self.get_words
    randoms = (RandomWord.nouns.next).split '_'

    randoms.map do |word|
      Word.new(word)
    end
  end
end
