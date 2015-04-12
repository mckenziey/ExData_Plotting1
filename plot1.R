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
plot.new()
with(mydata,hist(p1,breaks=24,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)"))
dev.copy(png,width=480,height=480,file="plot1.png")
dev.off()

