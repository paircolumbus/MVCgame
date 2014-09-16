require 'pry'

class SayIt
  attr_accessor :things, :first_try

  def initialize
    @things = IO.readlines 'en'
    @people = %w( Agnes Bruce Vicki Victoria )
    @first_try = true
  end



  def say(word)
    `say -v #{@people.shuffle.first} #{word}`
    #puts word
  end

  def says(word)
    threads = []
    @people.each do |person|
      threads << Thread.new do
        `say -v #{person} #{word}`
      end
    end
    threads.each {|t| t.join}
    #puts word
    sleep 1
  end

  def random_word
    @things[rand(@things.size)].chomp
  end

end
