plot1 <- function(){
  library(dplyr)
  # copy household_power_consumption.txt to the working directory
  setClass('myDate')
  setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
  setClass('myTime')
  setAs("character","myTime", function(from) strptime(from, format="%H:%M:%S") )
  data <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", 
                     stringsAsFactors = F, skip = 66637, nrows = 2880,
                     col.names = c("Date", "Time", "Global_active_power", 
                                   "Global_reactive_power", "Voltage", "Global_intensity", 
                                   "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                     colClasses = c("myDate","myTime", rep("numeric",7))
                     )
  
  png(filename = "plot1.png", width = 480, height = 480, units = "px")
  hist(data$Global_active_power, freq = T, col="red", 
       xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
  dev.off()
}