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
        # print_blank()
        body.each{ |line| print_line(line, @body_alignment) }
        print_blank()
        print_bar()
      end

      def print_line(line, align)
        # p line.scan(/\e/).count
        padding = (@screen_size - 6 + (line.scan(/\e/).count * 4) - line.length)
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

    end
  end
end
