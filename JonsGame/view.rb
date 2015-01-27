module GameView

 module Print

   class << self
     def run_spinner
       print "Loading (please wait) "
       #5.times { print "."; sleep 1; }
       5.times { print "."; }
       print "\n"
     end

     def error_message
        puts "That's not a command key. Try again!"
     end
       
     def title_screen
title = <<TITLE

     ***************** || ******************
     *         Retirement Comparer         *
     ***************** || ******************

TITLE
       puts title
     end

      def menu
menu = <<EOS

       ************** Welcome **************
       - (S1)etup retirement scenario 1
       - (S2)etup retirement scenario 2
       - (V)iew retirement incomes
       - (Q)uit program
       **************         **************

EOS
        puts menu
      end

      def print_retirement_comparison(scenario1, scenario2)
        output = [] 
        output[0]   = "********************************"
        output[1]   = ""
        output[2]   = "********************************"
        output[3]   = sprintf("%-21s", "Beginning Age:")
        output[4]   = sprintf("%-21s", "Retirement Age:")
        output[5]   = sprintf("%-21s", "Age of Death:")
        output[6]   = sprintf("%-21s", "Annual Contribution:")
        output[7]   = sprintf("%-21s", "Market Return:")
        output[8]   = sprintf("%-21s", "Accum. Tax Rate:")
        output[9]   = sprintf("%-21s", "Retir. Tax Rate:")
        output[10]  = sprintf("%-21s", "Account Type:")
        output[11]  = "********************************"
        output[12]  = sprintf("%-21s", "Retirement Income:")
        output[13]  = "********************************"
 
        output[1]  << sprintf("%-32s", scenario1.name)
        output[3]  << sprintf("%-12d", scenario1.beginning_age)
        output[4]  << sprintf("%-12d", scenario1.retirement_age)
        output[5]  << sprintf("%-12d", scenario1.death_age)
        output[6]  << sprintf("$%-11d", scenario1.annual_contribution)
        output[7]  << sprintf("%-12.2f", scenario1.accumulation_market_return_rate)
        output[8]  << sprintf("%-12.2f", scenario1.accumulation_tax_rate)
        output[9]  << sprintf("%-12.2f", scenario1.retirement_tax_rate)
        output[10]  << sprintf("%-12s", scenario1.ira_type.to_s)
        output[12] << sprintf("$%-11d", scenario1.retirement_income)

        output[0]  << " ********************************"
        output[1]  << " %s" % scenario2.name
        output[2]  << " ********************************"
        output[3]  << sprintf("%-12d", scenario2.beginning_age)
        output[4]  << sprintf("%-12d", scenario2.retirement_age)
        output[5]  << sprintf("%-12d", scenario2.death_age)
        output[6]  << sprintf("$%-11d", scenario2.annual_contribution)
        output[7]  << sprintf("%-12.2f", scenario2.accumulation_market_return_rate)
        output[8]  << sprintf("%-12.2f", scenario2.accumulation_tax_rate)
        output[9]  << sprintf("%-12.2f", scenario2.retirement_tax_rate)
        output[10] << sprintf("%-12s", scenario2.ira_type.to_s)
        output[11] << " ********************************"
        output[12] << sprintf("$%-11d", scenario2.retirement_income)
        output[13] << " ********************************"

        puts output
      end

      def serialize_scenario
        {}.tap do |args|
          args[:name] = fetch_user_input("\nEnter the name:")
          args[:beginning_age] = fetch_user_input("\nEnter beginning age:")
          args[:retirement_age] = fetch_user_input("\nEnter retirement age:")
          args[:death_age] = fetch_user_input("\nEnter age of death:")
          args[:annual_contribution] = fetch_user_input("\nEnter annual contribution:")
          args[:accumulation_market_return_rate] = fetch_user_input("\nEnter accumulation market return rate:")
          args[:accumulation_tax_rate] = fetch_user_input("\nEnter accumulation tax rate:")
          args[:retirement_tax_rate] = fetch_user_input("\nEnter retirement tax rate:")
          args[:ira_type] = fetch_user_input("\nEnter retirement type (roth, regular):").to_sym
        end
      end

      def fetch_user_input(question=nil)
        puts question if question
        print "> "
        gets.chomp
      end
    end
  end
end
