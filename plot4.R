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
png("plot4.png")

## setup a region for 4 plots
par(mfrow=c(2,2))

## create plots
with(hpcStudy,{
  ## top left
  plot( hpcStudy$RTStamp
       ,hpcStudy$Global_active_power
       ,type="l"
       ,xlab=""
       ,ylab="Global Active Power")
  ## top right
  plot( hpcStudy$RTStamp
       ,hpcStudy$Voltage
       ,type="l"
       ,xlab="datetime"
       ,ylab="Voltage")
  ## bottom left
  plot( hpcStudy$RTStamp
       ,hpcStudy$Sub_metering_1
       ,type="n"
       ,xlab=""
       ,ylab="Energy sub metering")
  with(hpcStudy, lines(RTStamp,Sub_metering_1, col="black"))
  with(hpcStudy, lines(RTStamp,Sub_metering_2, col="red"))
  with(hpcStudy, lines(RTStamp,Sub_metering_3, col="blue"))
  legend("topright"
         ,lty=1, col=c("black","red","blue")
         ,legend=c("Sub_metering_1"
                   ,"Sub_metering_2"
                   ,"Sub_metering_3")
                   , cex = 0.75)
  ## bottom right
  plot( hpcStudy$RTStamp
       ,hpcStudy$Global_reactive_power
       ,type="l"
       ,xlab="datetime"
       ,ylab="Global_reactive_power")
})

## Close graphic device
dev.off()
