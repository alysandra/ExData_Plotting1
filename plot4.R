##lines 2-14 copied from plot2
##to get full data
fool.data<- read.csv("~/mm/household_power_consumption.txt", header=T, sep=";", na.strings="?",
                     nrows=2075259,check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
##date
fool.data$Date <- as.Date(fool.data$Date, format = "%d/%m/%Y")

##subset data - take the data we need: feb 1st and feb 2nd, then deleting the larger file which is not needed
data <- subset(fool.data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(fool.data)

##converting the dates to be separated by intervals of one minute from 00:00 feb 1st to 23:59 feb 2nd
datetime <- paste(as.Date(data$Date), data$Time)
data$datetime <- as.POSIXct(datetime)

##for plot 4, graph from plot 2 is in position 1,1. plot3 is in position 2, 1
par(mfcol = c(2,2), mar = c(4,4,2,1), oma = c(0,0,0,0))

with(data, {
  ##plot 2
  plot(Global_active_power~datetime, type ="l", xlab ="", ylab ="Global Active Power")
  ## plot 3
  plot(Sub_metering_1 ~ datetime, type ="l", ylab = "Energy sub metering", xlab ="")
  lines(Sub_metering_2 ~ datetime, col ="Red")
  lines(Sub_metering_3 ~ datetime, col ="Blue")
  ## Add the legend, need to add lty/lwd or the colouring will not appear.
  legend("topright", legend =c("Sub metering_1", "Sub metering_2", "Sub metering_3"), 
         col=c("black", "red", "blue"), lty=1, lwd=2, bty="n")
  plot(Voltage~datetime, type="l")
  plot(Global_reactive_power~datetime, type="l")
})

##save to png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

