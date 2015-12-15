#test script
require 'json'

WORDS_REGEX = /\w+[a-z']*/

raw_data = File.new('schema.json').read
translation_hash = JSON.parse raw_data


input = nil

until ['q', 'quit'].include? input
  puts "Enter a string to translate into knight"
  input = gets.chomp.downcase
  words = input.scan WORDS_REGEX
  translation = words.collect {|word| translation_hash[word] || word }
  puts translation.join " "
end