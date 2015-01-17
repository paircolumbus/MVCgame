require_relative 'globals'



class GameController
  include GameView

  def run!
    # Print::display("Mikes page!" , ["Some stuff is crazy", "and that is why I love it", "be peaceful my friend"], "~Kenworthy", 80)
    @currState = InitState.new

    until @currState.is_a? EndState do
      Print::initialize("Hello world!", "~Kenworthy inc", 80)
      Print::display(@currState.getBody)

      @currState = @currState.send(Print::getInput(@currState.getQuestion))

    end

  end

=begin
  def run!
    todoList = List.new

    Print::run_spinner
    Print::title_screen

    #Make todoList methods like RESTful endpoints (new/edit/update/delete)
    #Think Backbone Model & View

    loop do
      Print::menu
      case Print::fetch_user_input
      when "V"
        Print::print_list(todoList.todos)
      when "A"
        todoList.add_todo(Print::serialize_todo)
      when "C"
        todoList.complete_todo(Print::completed_id.to_i)
      when "D"
        todoList.delete_todo(Print::deleted_id.to_i)
      when "Q"
        puts "We're done" 
        exit
      else
        Print::error_message
      end
    end
  end
=end

end

GameController.new.run!
