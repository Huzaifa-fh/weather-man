module Weatherman_Tools
  require_relative "cal_month"
  require_relative "cal_year"
  require_relative "two_horizontal_barChart"

  #Method to validate command-line
  #arguments passed in console
  def arg_validator()

    if ARGV.length != 3
      puts "Error: Wrong number of arguments"
      return false
    end

    unless ARGV[0] == "-e" or ARGV[0] == "-a" or ARGV[0] == "-c"
      puts "Error: Wrong flag argument"
      return false
    end

    if ARGV[0] == "-a" or ARGV[0] == "-c"
      year_month = ARGV[1].split("/")
      month = year_month[1].to_i
      if month < 1 or month > 12
        puts "Error: Wrong month range, should be between 1 and 12 inclusive"
        return false
      end
    end

    unless File.exist?(ARGV[2])
      puts "Error: Wrong file path"
      return false
    end

    return true
  end

  #Method to check the flag passed
  #and call respective function
  #also checks and outputs result
  def func_caller
    if ARGV[0] == "-e"
      final_result_obj = Cal_year.new(ARGV[1], ARGV[2])
      final_result_obj.cal_highest_temp
      final_result_obj.output_result
    elsif ARGV[0] == "-a"
      final_result_obj = Cal_month.new(ARGV[1], ARGV[2])
      final_result_obj.cal_avg_temp
      final_result_obj.output_result
    elsif ARGV[0] == "-c"
      puts "Enter 1 for bar charts on the same line"
      puts "Enter 2 for bar charts on different lines"
      print "Input: "
      flag = STDIN.gets.chomp.to_i

      if flag == 1 or flag == 2
        final_result_obj = BarChart.new(flag, ARGV[1], ARGV[2])
        final_result_obj.draw_chart
      elsif
        puts "Error: Entered value should be 1 or 2"
      end
    end
  end
end
