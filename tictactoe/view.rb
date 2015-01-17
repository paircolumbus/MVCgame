require_relative 'globals'

module GameView

  module Print

    class << self

      @@initilized = false

      def initialize(header, footer, screen_size, 
        header_alignment=:LEFT, body_alignment=:CENTER, footer_alignment=:RIGHT)
        @@initilized = true
        @header = header
        @footer = footer
        @header_alignment = header_alignment
        @body_alignment = body_alignment
        @footer_alignment = footer_alignment
        @screen_size = screen_size
        @screen_size -= 1 if (@screen_size % 2 != 0)
      end

      def getInput(question)
        question.each{ |line| print_line(line, :LEFT) }
        print ">> "
        gets.chomp
      end

      def display(body)
        system "clear" or system "cls"
        raise NotInitialized, "Please run the initialization before attempting display" unless @@initilized
        checkContent(@header, body, @footer)
        print_bar()
        print_line(@header, @header_alignment)
        print_bar()
        print_blank()
        body.each{ |line| print_line(line, @body_alignment) }
        print_blank()
        print_bar()
      end

      def print_line(line, align)
        padding = (@screen_size - 6 - line.length)
        if align == :LEFT
          puts "** " + line + (" " * padding) + " **"
        elsif align == :RIGHT
          puts "** " + (" " * (@screen_size - 6 - line.length)) + line + " **"
        elsif align == :CENTER
          right_pad = padding + 1 if padding / 2 != 0
          puts "** " + (" " * (padding / 2)) + line + (" " * (right_pad / 2)) + " **"
        end
      end

      def print_blank()
        puts "** " + (" " * (@screen_size - 6)) + " **"
      end

      def print_bar()
        line = ""
        nStars = ((@screen_size - 4) / 2)
        nStars.times{ line += "*" }
        line = line + " || "
        nStars.times{ line += "*" }
        puts line
      end

      def checkContent(header, body, footer)
        content = [header] + body + [footer]
        content.max do |a, b|
          b.length <=> a.length
        end
        raise TooMuchContent "Reduce line size..." unless content.first.length < (@screen_size - 6)
        # max(content.first.length,10)
      end
=begin

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
=end

    end
  end
end
