#set working directory
setwd("C:/Users/irfhli/Documents/R/exploratory/repo")
#read data into a dataframe
quiz1<-read.csv("household_power_consumption.txt",sep=";", header=TRUE, colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings="?")
#subsetting the data where Date = 1/2/2007 or 2/2/2007 
quizsubset1 <- subset (quiz1, Date == "1/2/2007")
quizsubset2 <- subset (quiz1, Date == "2/2/2007")
#creating one dataset with Dates 1/2/2007 & 2/2/2007
quiz1final <- rbind(quizsubset1, quizsubset2)
#concatenating date and time columns and converting datetime column
quiz1final$datetime <- paste(quiz1final$Date, quiz1final$Time, sep = " ")
quiz1final$DateTime <- as.POSIXct(strptime(quiz1final$datetime, "%d/%m/%Y %H:%M:%S"))
#creating panel plot
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2), mar = c(4, 4, 2, 2), oma = c(0, 0, 2, 0))
with(quiz1final,{
  plot(quiz1final$DateTime, quiz1final$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  plot(quiz1final$DateTime, quiz1final$Voltage, type="l", ylab="Voltage", xlab="datetime")
  plot(quiz1final$DateTime, quiz1final$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
  par(new=TRUE)
  plot(quiz1final$DateTime, quiz1final$Sub_metering_2, ylim = range(c(quiz1final$Sub_metering_1, quiz1final$Sub_metering_2)), col = "red", type="l", ylab="Energy sub metering", xlab="")
  par(new=TRUE)
  plot(quiz1final$DateTime, quiz1final$Sub_metering_3, ylim = range(c(quiz1final$Sub_metering_1, quiz1final$Sub_metering_2, quiz1final$Sub_metering_3)), col = "blue", type="l", ylab="Energy sub metering", xlab="")
  legend("topright", lty=c(1,1,1), cex = 0.8, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(quiz1final$DateTime, quiz1final$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})
dev.off()