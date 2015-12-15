require_relative 'view'
require_relative 'model'
require 'json'
require 'pry'

class TranslatorController
  attr_accessor :translation_dict

  include TranslatorView
  include TranslatorModel

  def initialize
    @translation_dict = Schema::import_translation_schema
  end

  def translate string
    words = string.scan Schema::WORDS_REGEX
    translated_words = words.collect { |w| @translation_dict[w] || w }
    translated_words.join " "
  end

  def play
    Display::title
    gets.chomp
    user_input = nil

    until ['quit', 'q', 'exit', 'e'].include? @user_input
      Display::menu
      user_input = gets.chomp.downcase
      case user_input
      when 'v' then Display::print_schema(translation_dict)
      when 'a' then add_new_entry
      when 'u' then nil
      when 'd' then nil
      when 's' then save_schema
      else
        puts translate @user_input
      end
      pause
    end
  end

  def pause
    Display::pause
    gets.chomp
  end

  def add_new_entry
    Display::request_english_word
    original = gets.chomp

    Display::request_translation
    translated = gets.chomp

    puts "Save new translation: #{original} => #{translated}?"
    confirmation = gets.chomp.downcase
    if ['y', 'yes'].include?(confirmation)
      @translation_dict[original] = translated
      puts "Change saved."
    else
      puts "Change rejected."
    end
  end

  def save_schema
    puts "Save current translation schema to file?"
    confirmation = gets.chomp.downcase
    if ['y', 'yes'].include?(confirmation)
      Schema::export_translation_schema(@translation_dict)
      puts "New schema saved."
    else
      puts "Schema changes cancelled."
    end
  end
end

translator = TranslatorController.new
translator.play