setwd("C:/Users/Stanislas/Datascience/Exploratory data analysis/Project 1 assignment")
install.packages("downloader")
library(downloader)
#dplyr provides a set of tools to efficiently manipulate data
install.packages("dplyr")
library(dplyr)
#download a file using http, https or ftp
download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dest="zipped.zip", mode="wb") 
unzip ("zipped.zip",exdir = "./unzipped")
data<-read.csv("./unzipped/household_power_consumption.txt",header=TRUE,sep=";")

#subset to keep onjly the two days
data2<-subset(data,data$Date == "1/2/2007"|data$Date == "2/2/2007")
#convert factor variables to numeric
data2$Global_active_power <- as.numeric(as.character(data2$Global_active_power))
data2$Global_reactive_power <- as.numeric(as.character(data2$Global_reactive_power))
data2$Voltage <- as.numeric(as.character(data2$Voltage))
#convert date and time to character vectors
data2$Date <- as.character(data2$Date)
data2$Time<- as.character(data2$Time)
#concatenate date and time
data2$datetime <- strptime(paste(data2$Date, data2$Time), "%d/%m/%Y %H:%M:%S")
#keep only relevant variables
data2 <- select(data2,datetime,Global_active_power:Sub_metering_3,-Date,-Time)


# Open png file
jpeg("plot3.png", width = 480, height = 480)
#plot 3: line charts of submetering 1,2 and 3
plot (x= data2$datetime, y = data2$Sub_metering_1,
      ylab = 'Energy sub metering',
      xlab ='  ',
      type = "l")
legend("topright" , lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
lines(x= data2$datetime, y = data2$Sub_metering_2, col = "red")
lines(x= data2$datetime, y = data2$Sub_metering_3, col = "blue")
# Close the file
dev.off()
