plot4 <- function(){
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
  par(mfrow=c(2,2))
  png(filename = "plot4.png", width = 480, height = 480, units = "px")
  #Plot1
  plot(data$Date_Time, data$Global_active_power, ylab = "Global Active Power",
       xlab="", type = "l")
  
  #Plot2
  plot(data$Date_Time, data$Voltage, ylab = "Voltage",
       xlab="datetime", type = "l")
  
  #Plot3
  plot(data$Date_Time, data$Sub_metering_1,   ylab = "Energy sub metering", xlab="", type = "l")
  lines(data$Date_Time, data$Sub_metering_2, col="red")
  lines(data$Date_Time, data$Sub_metering_3, col="blue")
  legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red", "blue"), lty=c(1,1,1))
  #Plot4
  plot(data$Date_Time, data$Global_reactive_power, ylab = "Global_reactive_power",
       xlab="datetime", type = "l")
  
  
  dev.off()
}