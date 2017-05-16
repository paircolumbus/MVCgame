module GameView
  module Print
    class << self
      def error_message
        puts "Oops, that doesn't appear to be a command key. Please try again!"
      end

      def welcome
welcome = <<WELCOME
    **********************
    *      WELCOME!      *
    **********************
WELCOME
        puts welcome
      end

      def menu
menu = <<MEN
    **********:)**********
    -> (V)iew your todos
    -> (A)dd a todo
    -> (C)omplete a todo
    -> (D)elete a todo
    -> (Q)uit program
    **********************
MEN
        puts menu
      end

      def print_list(todos)
        todos.each do |todo|
          if todo.completed?
            puts "[X] #{todo.id} || #{todo.name} - #{todo.description}"
          else
            puts "[X] #{todo.id} || #{todo.name} - #{todo.description}"
          end
        end
      end

      def serialize_todo
        {}.tap do |obj|
          ["\nName: ", "\nDescription: "].each do |t|
            if obj.empty?
              obj[:title] = fetch_input(t)
            else
              obj[:description] = fetch_input(t)
            end
          end
        end
      end

      def deleted_id
        given_id = "Enter the id of the todo you want to delete: "
        fetch_input(given_id)
      end

      def completed_id
        given_id = "Enter the id of the todo you want to mark as completed: "
        fetch_input(given_id)
      end

      def fetch_input(question=nil)
        puts question if question
        print "> "
        gets.chomp
      end
    end
  end
end
