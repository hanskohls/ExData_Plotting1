## read the data
data <- read.table("data.txt", sep=";", header=T, na.strings="?")

## convert the date factors to datestamp
dates = paste(data$Date, data$Time)
dates <- strptime(dates, "%d/%m/%Y %H:%M:%S")
data$Datestamp <- dates

## subset to Feb 1st/2nd in 2007
startdate <- strptime(c("2007/02/01 00:00:00"), "%Y/%m/%d %H:%M:%S" )
enddate <- strptime(c("2007/02/02 23:59:59"), "%Y/%m/%d %H:%M:%S" )
data <- subset(data, Datestamp >= startdate)
data <- subset(data, Datestamp <= enddate)

## convert the outputs as numeric
data.gap <- as.numeric(as.character(data$Global_active_power))
data.sm1 <- as.numeric(as.character(data$Sub_metering_1))
data.sm2 <- as.numeric(as.character(data$Sub_metering_2))
data.sm3 <- as.numeric(as.character(data$Sub_metering_3))
data.volt <- as.numeric(as.character(data$Voltage))
data.grp <- as.numeric(as.character(data$Global_reactive_power))
volt_name = "Voltage"
grp_name = "Global reactive power"
x_lab = "Datestamp"

## setup the multiplot
par(mfrow=c(2,2))
par(cex=.7)
par(lwi=.8)

## setup the plot
with(data, {
  plot(data$Datestamp, data.gap, type="l", col="black", ylab = "Global Active Power (kilowatts)", xlab="", main="")
  
  plot(data$Datestamp, data.volt, type="l", col="black", ylab = volt_name, xlab = x_lab)
  
  plot(data$Datestamp, data.sm1, type="l", col="black", ylab = "Energy sub metering", xlab="", main="")
  lines(data$Datestamp, data.sm2, col="red")
  lines(data$Datestamp, data.sm3, col="blue")
  place <- "topright"
  cols <- c("black", "red", "blue")
  ## NOTE: the '   .' is a fix as per https://class.coursera.org/exdata-002/forum/search?q=legend#11-state-query=legend 
  texts <- c("Sub_metering_1   .", "Sub_metering_2   .", "Sub_metering_3   .")
  par(cex=.4)
  legend(place, col=cols, texts, lty=1, bty = "n")
  par(cex=.7)
  plot(data$Datestamp, data.grp, type="l", col="black", ylab = grp_name, xlab = x_lab)
  }
)
## save the plot
dev.copy(png, file="plot4.png")
dev.off()
