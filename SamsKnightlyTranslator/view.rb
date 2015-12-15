#to-do:
#add views methods for:
#  add menu
#  update menu



module TranslatorView
  module Display
    class << self
      def title
title = <<TITLE

      WHAT HO!
    THOU SHALL BECOME KNIGHTLY
 WITH MINE AMAZING KNIGHTLY TRANSLATOR

             ,;~;,
                /\_
               (  /
               ((),     ;,;
               |  \\  ,;;'(
           __ _(  )'~;;'   \
         /'  '\'()/~' \ /'\.)
      ,;(      )||     |
     ,;' \    /-(.;,   )
          ) /       ) /
         //         ||
        (_\         (_\

***** PRESS ANY KEY TO CONTINUE *****

TITLE
      puts title
      end

      def menu

menu = <<MENU

                |        l~~~~~~~l      |
                /\   l^^^^^^^^^^^^^^^l  /\
               /__\ _l O  O  O  O  O l_/__\
               l   l l               l     l
               l   l l               l     l
[^^^]          l  [^^^]             [^^^]  l          [^^^]
[ o ]-------------[ o ]-------------[ o ]-------------[ o ]
[   ]             [   ]     ___     [   ]             [   ]
[   ]             [   ]    /   \    [   ]             [   ]
[   ]             [   ]   |     |   [   ]   o         [   ]
[   ]             [   ]   |     |   [   ]~\_|_        [   ]
[___]_____________[___]___|_____|___[___]_/\_/\_______[___]__



                ********** HARK! ************
                - Enter text to knightify, OR
                - (V)iew translation schema
                - (A)dd a new translation
                - (U)pdate a translation
                - (D)elete a translation
                - (S)ave schema to file
                - (Q)uit program
                **********      *************
MENU
      puts menu
      end

      def print_schema source
        puts "ORIGINAL // TRANSLATED"
        source.each do |original, translated|
          puts"#{original} => #{translated}"
        end
      end

      def pause
        puts "Press enter to return to menu"
      end

      def request_english_word
        puts "Please enter the modern english word for the entry"
      end

      def request_translation
        puts "Please enter the knightly translation"
      end

      def confirm?
        puts "Save changes? Y"
      end
    end
  end
end

#p TranslatorView::Display.methods.sort





