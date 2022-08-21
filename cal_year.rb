#Class to calculate data for a given year
class Cal_year
  require_relative "month_checker"

  def initialize (file_year, file_path)
    @file_year = file_year
    @file_path = file_path
    @final_result = Array[-Float::INFINITY, "Error: Highest Temperatue Data Does Not Exist",
      Float::INFINITY, "Error: Lowest Temperatue Data Does Not Exist",
      -Float::INFINITY, "Error: Highest Humidity Data Does Not Exist"]
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
  def cal_highest_temp

    file_path_names = @file_path.split("/")
    city_name = file_path_names[file_path_names.length - 1]
    @file_path = @file_path + "/" + city_name + "_" + @file_year + "_"

    actual_final_result = []
    actual_file_path = ""

    for i in 0..11
      actual_file_path = @file_path + @months[i] + ".txt"
      if (File.file?(actual_file_path))
        temp_month = Month_checker.new(actual_file_path)
        actual_final_result = temp_month.highest_year(city_name)

        if i == 0
          @final_result = actual_final_result
        else
          if actual_final_result[0] > @final_result[0]
            @final_result[0] = actual_final_result[0]
            @final_result[1] = actual_final_result[1]
          end
          if actual_final_result[2] < @final_result[2]
            @final_result[2] = actual_final_result[2]
            @final_result[3] = actual_final_result[3]
          end
          if actual_final_result[4] > @final_result[4]
            @final_result[4] = actual_final_result[4]
            @final_result[5] = actual_final_result[5]
          end
        end
      else
        puts "File: #{actual_file_path} does not exist"
      end
    end
  end

  def output_result
    if @final_result[0] != -Float::INFINITY
      print "Highest: #{@final_result[0]}C on "
    end
    puts @final_result[1]

    if @final_result[2] != Float::INFINITY
      print "Lowest: #{@final_result[2]}C on "
    end
    puts @final_result[3]

    if @final_result[0] != -Float::INFINITY
      print "Humid: #{@final_result[4]}% on "
    end
    puts @final_result[5]
  end
end
