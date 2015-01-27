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
        output = Array.new(14, "")
        add_frame output
        add_row_header output

        add_scenario_output(output, scenario1)
        add_frame output
        add_scenario_output(output, scenario2)
        puts output
        puts results_output(scenario1, scenario2)
      end

      def add_scenario_output(output, scenario)
        output[1]  += sprintf("%-32s", scenario.name)
        output[3]  += sprintf("%-12d", scenario.beginning_age)
        output[4]  += sprintf("%-12d", scenario.retirement_age)
        output[5]  += sprintf("%-12d", scenario.death_age)
        output[6]  += sprintf("$%-11d", scenario.annual_contribution)
        output[7]  += sprintf("%-12.2f", scenario.accumulation_market_return_rate)
        output[8]  += sprintf("%-12.2f", scenario.accumulation_tax_rate)
        output[9]  += sprintf("%-12.2f", scenario.retirement_tax_rate)
        output[10] += sprintf("%-12s", scenario.ira_type.to_s)
        output[12] += sprintf("$%-11d", scenario.retirement_income)
      end

      def add_frame(output)
        output[0]   += "********************************"
        output[1]   += ""
        output[2]   += "********************************"
        output[3]   += ""
        output[4]   += ""
        output[5]   += ""
        output[6]   += ""
        output[7]   += ""
        output[8]   += ""
        output[9]   += ""
        output[10]  += ""
        output[11]  += "********************************"
        output[12]  += ""
        output[13]  += "********************************"
      end

      def add_row_header(output)
        output[0]   += ""
        output[1]   += ""
        output[2]   += ""
        output[3]   += sprintf("%-21s", "Beginning Age:")
        output[4]   += sprintf("%-21s", "Retirement Age:")
        output[5]   += sprintf("%-21s", "Age of Death:")
        output[6]   += sprintf("%-21s", "Annual Contribution:")
        output[7]   += sprintf("%-21s", "Market Return:")
        output[8]   += sprintf("%-21s", "Accum. Tax Rate:")
        output[9]   += sprintf("%-21s", "Retir. Tax Rate:")
        output[10]  += sprintf("%-21s", "Account Type:")
        output[11]  += ""
        output[12]  += sprintf("%-21s", "Retirement Income:")
        output[13]  += ""
      end  

      def results_output(scenario1, scenario2)
        if scenario1.retirement_income == scenario2.retirement_income
          "Result: both scenarios generate the same income in retirement."
        elsif scenario1.retirement_income > scenario2.retirement_income
          "Result: #{scenario1.name} generates $#{scenario1.retirement_income - scenario2.retirement_income} more income in retirement!"
        else 
          "Result: #{scenario2.name} generates $#{scenario2.retirement_income - scenario1.retirement_income} more income in retirement!"
        end
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
