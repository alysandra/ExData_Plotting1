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
data$Datetime <- as.POSIXct(datetime)

##Create plot 2, line graph, no xlab, no title
plot(data$Global_active_power~data$Datetime, type ="l", xlab ="", ylab ="Global Active Power (Kilowatts)")

##copy to PNG file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()