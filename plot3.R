plot3 <- function(){
  
  library(dplyr)
  library(lubridate)
  
  setClass('myDate')
  setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
  # copy household_power_consumption.txt to the working directory
  data <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", 
                     stringsAsFactors = F, skip = 66637, nrows = 2880,
                     col.names = c("Date", "Time", "Global_active_power", 
                                   "Global_reactive_power", "Voltage", "Global_intensity", 
                                   "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                     colClasses = c("myDate","character", rep("numeric",7))
  )
  data <- mutate(data, Date_Time=ymd_hms(paste(Date, " " ,Time)))
  png(filename = "plot3.png", width = 480, height = 480, units = "px")
  plot(data$Date_Time, data$Sub_metering_1,   ylab = "Energy sub metering", xlab="", type = "l")
  lines(data$Date_Time, data$Sub_metering_2, col="red")
  lines(data$Date_Time, data$Sub_metering_3, col="blue")
  legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red", "blue"), lty=c(1,1,1))
  dev.off()
}