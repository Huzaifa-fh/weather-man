#Class to calculate data for a given month
class Cal_month
  require_relative "month_checker"

  def initialize (file_year_month, file_path)
    @file_year_month = file_year_month
    @file_path = file_path
    @final_result = []
    @months = {
      0 => "Jan",
      1 => "Feb",
      2 => "Mar",
      3 => "Apr",
      4 => "May",
      5 => "Jun",
      6 => "Jul",
      7 => "Aug",
      8 => "Sep",
      9 => "Oct",
      10 => "Nov",
      11 => "Dec"
    }
  end

  #Method to check if given file path
  #is valid and then it creates a month_checker obj
  #and then calls respective method from said class
  def cal_avg_temp
    actual_file_path = ""
    actual_final_result = [-Float::INFINITY, -Float::INFINITY, -Float::INFINITY]

    file_path_names = @file_path.split("/")
    city_name = file_path_names[file_path_names.length - 1]

    actual_year_month = @file_year_month.split("/")
    actual_year = actual_year_month[0]
    actual_month = actual_year_month[1].to_i
    actual_file_path = @file_path + "/" + city_name + "_" + actual_year + "_" + @months[actual_month - 1] + ".txt"

    if (File.file?(actual_file_path))
      temp_month = Month_checker.new(actual_file_path)
      actual_final_result = temp_month.highest_month(city_name)
    elsif
      puts "Error: file path #{actual_file_path} does not exist"
    end
    @final_result = actual_final_result
  end


  def output_result
    if @final_result[0] == Float::INFINITY then puts "Error: Highest Average Data Does Not Exist"
    elsif @final_result[0] != -Float::INFINITY then puts "Highest Average: #{@final_result[0]}C" end

    if @final_result[1] == Float::INFINITY then puts "Error: Lowest Average Data Does Not Exist"
    elsif @final_result[1] != -Float::INFINITY then puts "Lowest Average: #{@final_result[1]}C" end

    if @final_result[2] == Float::INFINITY then puts "Error: Average Humidity Data Does Not Exist"
    elsif @final_result[2] != -Float::INFINITY then puts "Average Humidity: #{@final_result[2]}C" end
  end
end
