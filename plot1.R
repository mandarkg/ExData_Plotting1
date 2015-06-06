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
#creating histogram for Global Active Power
hist(quiz1final$Global_active_power,col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
#creating PNG image of the plot
dev.copy(png, file="plot1.png")
dev.off()