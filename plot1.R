## read complete dataset
hpc<-read.table( './data/household_power_consumption.txt'
                 ,header=TRUE
                 ,sep = ";"
                 ,na.strings = "?")

## extract data for 1st and 2nd of february 2007
hcpStudy<- subset(hpc, hpc$Date %in% c("1/2/2007","2/2/2007"))

## prepare plotting to a png file (480x480 by default)
png("plot1.png")

hist( hcpStudy$Global_active_power
     ,main="Global Active Power"
     ,xlab="Global Active Power (kilowatts)"
     ,col="red")

## close graphic device
dev.off()

