## read complete dataset
hpc<-read.table( './data/household_power_consumption.txt'
                ,header=TRUE
                ,sep = ";"
                ,na.strings = "?")

## extract data for 1st and 2nd of february 2007
hpcStudy<- subset(hpc, hpc$Date %in% c("1/2/2007","2/2/2007"))

## concatenate date and time
hpcStudy$TStamp <- paste(hpcStudy$Date," ", hpcStudy$Time)
## convert to R datetime format
hpcStudy$RTStamp <- strptime(hpcStudy$TStamp, format="%d/%m/%Y %H:%M:%S")

## prepare plotting to a png file (480x480 by default)
png("plot3.png")

## create empty plot
plot( hpcStudy$RTStamp
     ,hpcStudy$Sub_metering_1
     ,type="n"
     ,xlab = ""
     ,ylab="Energy sub metering")
## populate plot
with(hpcStudy,lines(RTStamp,Sub_metering_1, col="black"))
with(hpcStudy,lines(RTStamp,Sub_metering_2, col="red"))
with(hpcStudy,lines(RTStamp,Sub_metering_3, col="blue"))

## close graphic device
dev.off()
