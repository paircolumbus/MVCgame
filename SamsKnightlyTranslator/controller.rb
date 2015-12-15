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
    pause
    user_input = nil

    until ['quit', 'q', 'exit', 'e'].include? user_input
      Display::menu
      user_input = gets.chomp.downcase
      case user_input
      when 'v' then Display::print_schema(translation_dict)
      when 'a' then add_new_entry
      when 'u' then update_entry
      when 'd' then delete_entry
      when 's' then save_schema
      else
        puts translate user_input
      end
      pause
    end
    puts "~ Fare thee well ~"
  end

  def pause
    Display::pause
    gets.chomp
  end

  def get_input
    gets.chomp.downcase
  end

  def confirm?
    ['y', 'yes'].include? get_input
  end

  def add_new_entry
    Display::request_english_word
    original = get_input

    if @translation_dict[original]
      puts "Translation already exists; use (U)pdate to modify."
      return
    end

    Display::request_translation
    translated = get_input

    puts "Save new translation: #{original} => #{translated}?"
    if confirm?
      Schema::update_entry(@translation_dict, original, translated)
      #@translation_dict[original] = translated
      puts "Change saved."
    else
      puts "Change rejected."
    end
  end

  def save_schema
    puts "Save current translation schema to file?"
    if confirm?
      Schema::export_translation_schema(@translation_dict)
      puts "New schema saved."
    else
      puts "Schema changes cancelled."
    end
  end

  def delete_entry
    Display::request_english_word
    target = get_input

    case
    when (@translation_dict.keys.include? target)
      puts "Destroy #{target} => #{@translation_dict[target]}?"
      if confirm?
        Schema::destroy_entry(@translation_dict, target)
        puts "Translation deleted."
      else
        puts "Canceling deletion."
      end
    else
      puts "Translation not found in current schema. Returning to menu."
    end
  end

  def update_entry
    Display::request_english_word
    target = get_input

    case
    when @translation_dict.keys.include?(target)
      puts "Current translation: #{target} => #{@translation_dict[target]}"
      puts "Enter new translation for this word."
      new_translation = get_input

      puts "Save updated entry: #{target} => #{new_translation}?"
      if confirm?
        Schema::update_entry(@translation_dict, target, new_translation)
        #@translation_dict[target] = new_translation
        puts "Entry updated."
      else
        puts "Canceled update."
      end
    else puts "No entry found to update. Use (A)dd to enter a new entry."
    end
  end
end

translator = TranslatorController.new
translator.play