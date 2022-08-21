#Class for printing colored string on console
class String
  def red;            "\e[31m#{self}\e[0m" end
  def blue;           "\e[34m#{self}\e[0m" end
end

#Class for checking data of each month
class Month_checker

  def initialize(filepath)

    #All individual file headers are initialized to -1
    @PKT = -1
    @Max_TemperatureC = -1
    @Mean_TemperatureC = -1
    @Min_TemperatureC = -1
    @Dew_PointC = -1
    @MeanDew_PointC = -1
    @Min_DewpointC = -1
    @Max_Humidity = -1
    @Mean_Humidity = -1
    @Min_Humidity = -1
    @Max_Sea_Level_PressurehPa = -1
    @Mean_Sea_Level_PressurehPa = -1
    @Min_Sea_Level_PressurehPa = -1
    @Max_VisibilityKm = -1
    @Mean_VisibilityKm = -1
    @Min_VisibilitykM = -1
    @Max_Wind_SpeedKm_h = -1
    @Mean_Wind_SpeedKm_h = -1
    @Max_Gust_SpeedKm_h = -1
    @PrecipitationCm  = -1
    @CloudCover = -1
    @Events = -1
    @WindDirDegrees = -1

    @filepath = filepath

    @months = {
      "1" => "January",
      "2" => "February",
      "3" => "March",
      "4" => "April",
      "5" => "May",
      "6" => "June",
      "7" => "July",
      "8" => "August",
      "9" => "September",
      "10" => "October",
      "11" => "November",
      "12" => "December"
    }
  end

  #Method to check and assign
  #respective index to passed array
  def index_setter(index_arr)
    for i in 0..index_arr.length
      case index_arr[i]
      when "PKT", "PKST", "GST" then @PKT = i
      when "Mean TemperatureC" then @Mean_TemperatureC = i
      when "Min TemperatureC" then @Min_TemperatureC = i
      when "Dew PointC" then @Dew_PointC = i
      when "MeanDew PointC" then @MeanDew_PointC = i
      when "Min DewpointC" then @Min_DewpointC = i
      when "Max Humidity" then @Max_Humidity = i
      when "Mean Humidity" then @Mean_Humidity = i
      when "Min Humidity" then @Min_Humidity = i
      when "Max Sea Level PressurehPa" then @Max_Sea_Level_PressurehPa = i
      when "Mean Sea Level PressurehPa" then @Mean_Sea_Level_PressurehPa = i
      when "Min Sea Level PressurehPa" then @Min_Sea_Level_PressurehPa = i
      when "Max VisibilityKm" then @Max_VisibilityKm = i
      when "Mean VisibilityKm" then @Mean_VisibilityKm = i
      when "Min VisibilitykM" then @Min_VisibilitykM = i
      when "Max Wind SpeedKm/h" then @Max_Wind_SpeedKm_h = i
      when "Mean Wind SpeedKm/h" then @Mean_Wind_SpeedKm_h = i
      when "Max Gust SpeedKm/h" then @Max_Gust_SpeedKm_h = i
      when "Max TemperatureC" then @Max_TemperatureC = i
      when "PrecipitationCm" then @PrecipitationCm = i
      when "CloudCover" then @CloudCover = i
      when "Events" then @Events = i
      when "TemperatureC" then @WindDirDegrees = i
      end
    end
  end

  #Method to check and compare all values
  #of given month and return the highest
  #values of said month
  def highest_year(city_flag)
    highest_temp = -Float::INFINITY
    highest_temp_day = "" #day of highest temperatue

    lowest_temp = Float::INFINITY
    lowest_temp_day = "" #day of lowest temperature

    highest_humidity = -Float::INFINITY
    highest_humidity_day = "" #day of highest humidity

    File.open(@filepath, "r") do |file|
      if city_flag == "lahore_weather" then file.readline() end
      index = file.readline().gsub(/[\s]*,[\s]*/, ",").split(",")
      index_setter(index)

      #Data is being read line by line
      #At one point, only 1 line of data
      #of 1 .txt file resides in memory
      for line in file.readlines()
        data = line
        data = data.gsub(/(<!--.*-->)/m, "")
        data = data.split(",")

        if @Max_TemperatureC != -1 and data[@Max_TemperatureC] != "" and data.length > 1
          line_highest_temp = data[@Max_TemperatureC].to_i
          if data[@Max_TemperatureC] != "" and line_highest_temp > highest_temp
            highest_temp = line_highest_temp

            line_date = data[@PKT].split("-")
            month = line_date[1]
            day = line_date[2]
            highest_temp_day = @months[month] + " " + day
          end
        end

        if @Min_TemperatureC != -1 and data[@Min_TemperatureC] != "" and data.length > 1
          line_lowest_temp = data[@Min_TemperatureC].to_i
          if data[@Min_TemperatureC] != "" and line_lowest_temp < lowest_temp
            lowest_temp = line_lowest_temp

            line_date = data[@PKT].split("-")
            month = line_date[1]
            day = line_date[2]
            lowest_temp_day = @months[month] + " " + day
          end
        end

        if @Max_Humidity != -1 and data[@Max_Humidity] != "" and data.length > 1
          line_highest_humidity = data[@Max_Humidity].to_i
          if data[@Max_Humidity] != "" and line_highest_humidity > highest_humidity
            highest_humidity = line_highest_humidity

            line_date = data[@PKT].split("-")
            month = line_date[1]
            day = line_date[2]
            highest_humidity_day = @months[month] + " " + day
          end
        end
      end
    end
    return highest_temp, highest_temp_day, lowest_temp, lowest_temp_day, highest_humidity, highest_humidity_day
  end

  #Method to add and return
  #average values of given month
  def highest_month(city_flag)
    avg_highest_temp = 0.0
    avg_highest_temp_days = 0

    avg_lowest_temp = 0.0
    avg_lowest_temp_days = 0

    avg_mean_humidity = 0.0
    avg_mean_humidity_days = 0

    #Data is being read line by line
    #At one point, only 1 line of data
    #of 1 .txt file resides in memory
    File.open(@filepath, "r") do |file|
      if city_flag == "lahore_weather" then file.readline() end
      index = file.readline().gsub(/[\s]*,[\s]*/, ",").split(",")
      index_setter(index)

      for line in file.readlines()
        data = line
        data = data.gsub(/(<!--.*-->)/m, "")
        data = data.split(",")

        if @Max_TemperatureC != -1 and data[@Max_TemperatureC] != "" and data.length > 1
          avg_highest_temp += data[@Max_TemperatureC].to_i
          avg_highest_temp_days += 1
        end

        if @Min_TemperatureC != -1 and data[@Min_TemperatureC] != "" and data.length > 1
          avg_lowest_temp += data[@Min_TemperatureC].to_i
          avg_lowest_temp_days += 1
        end

        if @Mean_Humidity != -1 and data[@Mean_Humidity] != "" and data.length > 1
          avg_mean_humidity += data[@Mean_Humidity].to_i
          avg_mean_humidity_days += 1
        end
      end
    end

    #Checks implemented incase no
    #data exists for a given month
    if avg_highest_temp_days == 0 then avg_highest_temp = Float::INFINITY
    else avg_highest_temp /= avg_highest_temp_days end

    if avg_lowest_temp_days == 0 then avg_lowest_temp = Float::INFINITY
    else avg_lowest_temp /= avg_lowest_temp_days end

    if avg_mean_humidity_days == 0 then avg_mean_humidity = Float::INFINITY
    else avg_mean_humidity /= avg_mean_humidity_days end

    return avg_highest_temp, avg_lowest_temp, avg_mean_humidity
  end

  #Method to print highest and
  #lowest temperature bar charts on
  #different lines of a given month
  def two_hori_barCharts(city_flag)
    month_output_count = 0

    #Data is being read line by line
    #At one point, only 1 line of data
    #of 1 .txt file resides in memory
    File.open(@filepath, "r") do |file|
      if city_flag == "lahore_weather" then file.readline() end
      index = file.readline().gsub(/[\s]*,[\s]*/, ",").split(",")
      index_setter(index)

      for line in file.readlines()
        data = line
        data = data.gsub(/(<!--.*-->)/m, "")
        data = data.split(",")

        #Used to output date before bar charts
        if month_output_count == 0
          year_month_day_output = data[@PKT].split("-")
          year_output = year_month_day_output[0]
          month_output = year_month_day_output[1]
          date_output = @months[month_output] + " " + year_output
          puts date_output

          month_output_count += 1
        end

        if @Max_TemperatureC != -1 and data[@Max_TemperatureC] != "" and data.length > 1
          line_max_temp = data[@Max_TemperatureC].to_i
          line_date = data[@PKT].split("-")
          day = line_date[2].to_i

          if day < 10 then print "0" end
          print "#{day} "
          if line_max_temp.positive? then (line_max_temp).times { |i| print "+".red }
          else
            line_max_temp_abs = line_max_temp.abs
            (line_max_temp_abs).times { |i| print "-".red }
          end
          puts " #{line_max_temp}C"
        end

        if @Min_TemperatureC != -1 and data[@Min_TemperatureC] != "" and data.length > 1
          line_min_temp = data[@Min_TemperatureC].to_i
          line_date = data[@PKT].split("-")
          day = line_date[2].to_i

          if day < 10 then print "0" end
          print "#{day} "
          if line_min_temp.positive? then (line_min_temp).times { |i| print "+".blue }
          else
            line_min_temp_abs = line_min_temp.abs
            (line_min_temp_abs).times { |i| print "-".blue }
          end
          puts " #{line_min_temp}C"
        end
      end
    end
  end

  #Method to print highest and
  #lowest temperature bar charts
  #on same lines of a given month
  def one_hori_barCharts(city_flag)
    month_output_count = 0

    #Data is being read line by line
    #At one point, only 1 line of data
    #of 1 .txt file resides in memory
    File.open(@filepath, "r") do |file|
      if city_flag == "lahore_weather" then file.readline() end
      index = file.readline().gsub(/[\s]*,[\s]*/, ",").split(",")
      index_setter(index)

      for line in file.readlines()
        data = line
        data = data.gsub(/(<!--.*-->)/m, "")
        data = data.split(",")

        line_min_temp = 0
        line_max_temp = 0

        endline_required = false #Incase data for max temp does not exist

        #Used to output date before bar charts
        if month_output_count == 0
          year_month_day_output = data[@PKT].split("-")
          year_output = year_month_day_output[0]
          month_output = year_month_day_output[1]
          date_output = @months[month_output] + " " + year_output
          puts date_output

          month_output_count += 1
        end

        line_min_temp = Float::INFINITY

        if @Min_TemperatureC != -1 and data[@Min_TemperatureC] != "" and data.length > 1
          line_min_temp = data[@Min_TemperatureC].to_i
          line_date = data[@PKT].split("-")
          day = line_date[2].to_i

          if day < 10 then print "0" end
          print "#{day} "
          if line_min_temp.positive? then (line_min_temp).times { |i| print "+".blue }
          else
            line_min_temp_abs = line_min_temp.abs
            (line_min_temp_abs).times { |i| print "-".blue }
          end
        end

        if @Max_TemperatureC != -1 and data[@Max_TemperatureC] != "" and data.length > 1
          line_max_temp = data[@Max_TemperatureC].to_i
          line_date = data[@PKT].split("-")
          day = line_date[2].to_i

          if line_max_temp.positive? then (line_max_temp).times { |i| print "+".red }
          else
            line_max_temp_abs = line_max_temp.abs
            (line_max_temp_abs).times { |i| print "-".red }
          end
          print " "
          if line_min_temp != Float::INFINITY then print "#{line_min_temp}C[-]" end
          puts "#{line_max_temp}C"
        else
          endline_required = true
        end

        if endline_required and line_min_temp != Float::INFINITY
          puts " #{line_min_temp}C"
          endline_required = false
        end

      end
    end
  end
end
