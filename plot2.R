plot2 <- function(){
  library(dplyr)
  # copy household_power_consumption.txt to the working directory
  setClass('myDate')
  setAs("character","myTime", function(from) strptime(from, format="%H:%M:%S") )
  data <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", 
                     stringsAsFactors = F, skip = 66637, nrows = 2880,
                     col.names = c("Date", "Time", "Global_active_power", 
                                   "Global_reactive_power", "Voltage", "Global_intensity", 
                                   "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                     colClasses = c("myDate","character", rep("numeric",7))
  )
  data <- mutate(data, Date_Time=ymd_hms(paste(Date, " " ,Time)))
  png(filename = "plot2.png", width = 480, height = 480, units = "px")
  plot(data$Date_Time, data$Global_active_power, ylab = "Global Active Power (kilowatts)",
       xlab="", type = "l")
  dev.off()
}