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
#creating line plot for submetering
#creating PNG image of the plot
par(mfrow=c(1,1))
png(file="plot3.png", width = 480, height = 480)
plot(quiz1final$DateTime, quiz1final$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
par(new=TRUE)
plot(quiz1final$DateTime, quiz1final$Sub_metering_2, ylim = range(c(quiz1final$Sub_metering_1, quiz1final$Sub_metering_2)), col = "red", type="l", ylab="Energy sub metering", xlab="")
par(new=TRUE)
plot(quiz1final$DateTime, quiz1final$Sub_metering_3, ylim = range(c(quiz1final$Sub_metering_1, quiz1final$Sub_metering_2, quiz1final$Sub_metering_3)), col = "blue", type="l", ylab="Energy sub metering", xlab="")
legend("topright", lty=c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()