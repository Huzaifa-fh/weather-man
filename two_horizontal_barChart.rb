#Class to calculate data for a given year
class BarChart
  require_relative "month_checker"

  def initialize (flag, file_year_month, file_path)
    @flag = flag
    @file_year_month = file_year_month
    @file_path = file_path
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
  def draw_chart
    file_path_names = @file_path.split("/")
    city_name = file_path_names[file_path_names.length - 1]

    actual_year_month = @file_year_month.split("/")
    actual_year = actual_year_month[0]
    actual_month = actual_year_month[1].to_i
    actual_file_path = @file_path + "/" + city_name + "_" + actual_year + "_" + @months[actual_month - 1] + ".txt"

    if (File.file?(actual_file_path))

      if @flag == 1
        temp_month = Month_checker.new(actual_file_path)
        temp_month.one_hori_barCharts(city_name)
      elsif @flag == 2
        temp_month = Month_checker.new(actual_file_path)
        temp_month.two_hori_barCharts(city_name)
      end
    elsif
      puts "Error: file path #{actual_file_path} does not exist"
    end
  end
end
