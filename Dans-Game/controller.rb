require_relative 'view'
require_relative 'model'

class Controller
  include View

  def initialize
    @beerList = List.new
  end

  def add_beer
    @beerList.add_beer Print::serialize_add_beer
  end

  def edit_beer
    id = Print::get_input("\nEnter the id of the beer you want to EDIT:").to_i
    b = @beerList.find_beer id
    fail "No beer matching id #{id}" unless b
    @beerList.edit_beer(Print::serialize_edit_beer(b.name, b.brewer, b.rating), id)
  end

  def delete_beer
    id = Print::get_input "\nEnter the id of the beer you want to DELETE:"
    @beerList.delete_beer id.to_i
  end

  def sort_list
    cmd = Print::get_input "\nEnter the sort method (N)ame/(B)rewer/(R)ating/(I)d:"
    case cmd.upcase
    when 'N'
      @beerList.sort_by_name!
    when 'B'
      @beerList.sort_by_brewer!
    when 'R'
      @beerList.sort_by_rating!
    else
      @beerList.sort_by_id!
    end
  end

  def run!
    Print::run_spinner
    Print::title_screen

    loop do
      Print::menu
      case Print::get_input.upcase
      when "V"
        Print::print_list(@beerList.beers)
      when "A"
        add_beer
      when "E"
        edit_beer
      when "D"
        delete_beer
      when "S"
        sort_list
      when "Q"
        puts "Cheers!" 
        exit
      else
        Print::error_message
      end
    end
  end
end

Controller.new.run!
