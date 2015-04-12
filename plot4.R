setwd("/Users/mckenzieyoung/Documents/ExData_Plotting1")
library(foreign)
library(xlsx)
library(XML)
library(data.table)
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataset_url, "power.zip",method="curl")
unzip("power.zip", exdir = "power")
mydata1 <- read.table("power/household_power_consumption.txt",header=TRUE,sep=";",stringsAsFactors=FALSE)
mydata1$Date <- as.Date(as.character(mydata1$Date),"%d/%m/%Y")
DATE1 <- as.Date("2007-02-01")
DATE2 <- as.Date("2007-02-02")
mydata <- mydata1[mydata1$Date==DATE1|mydata1$Date==DATE2,]
mydata$p1 <- as.numeric(as.character(mydata$Global_active_power))
mydata2 <- mydata[complete.cases(mydata),]
mydata2$dates <- as.POSIXct(paste(mydata2$Date, mydata2$Time), format="%Y-%m-%d %H:%M:%S")
par(mfrow=c(2,2))
with(mydata2,plot(dates,p1,type="l",ylab="Global Active Power (kilowatts)",xlab=" "))

with(mydata2,plot(dates,Voltage,type="l",ylab="Voltage",xlab="datetime",yaxt='n'))
axis(side = 2,labels=FALSE,tick=TRUE)
axis(side = 2, at = seq(234, 246, by = 4),tick=FALSE)

with(mydata2,plot(dates,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=" "))
with(mydata2,lines(dates,Sub_metering_2,type="l",col="red"))
with(mydata2,lines(dates,Sub_metering_3,type="l",col="blue"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=1,col=c("black","red","blue"),bty = "n")

with(mydata2,plot(dates,Global_reactive_power,type="l",xlab="datetime"))

dev.copy(png,width=480,height=480,file="plot4.png")
dev.off()