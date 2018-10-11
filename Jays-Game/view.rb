module GameView

  module Print

  class << self
    def run_spinner
      print "Loading (please wait) "
        5.times { print "."; sleep 1; }
        print "\n"
      end

      def error_message
        puts "That's not a command key. Try again!"
      end

      def title_screen
title = <<TITLE

     ********** || **********
     *      TODO MAGIC      *
     ********** || **********

TITLE
  puts title
  end

      def menu
menu = <<EOS

       ***** Welcome *****
      - (V)iew your todos
      - (A)dd a todo
      - (C)omplete a todo
      - (D)elete a todo
      - (Q)uit program
       *****         *****

EOS
        puts menu
      end

      #does print_list know too much about the underlying object???

      def print_list(todos)
        todos.each do |todo|
          if todo.completed?
            puts "[X] #{todo.id} || #{todo.title} - #{todo.description}" 
          else
            puts "[_] #{todo.id} || #{todo.title} - #{todo.description}" 
          end
        end
      end

      def serialize_todo
        {}.tap do |obj| 
          ["\nEnter the title:", "\nEnter the description:"].each do |t| 
            if obj.empty?
              obj[:title] = fetch_user_input(t)
            else
              obj[:description] = fetch_user_input(t)
            end
          end
        end
      end

      def deleted_id
        gimme_id = "\nEnter the id of todo item you want to DELETE:"
        fetch_user_input(gimme_id)
      end

      def completed_id
        gimme_id = "\nEnter the id of todo item you want to mark as COMPLETED:"
        fetch_user_input(gimme_id)
      end

      def fetch_user_input(question=nil)
        puts question if question
        print "> "
        gets.chomp
      end
    end
  end
end
