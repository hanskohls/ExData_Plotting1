## read the data
data <- read.table("data.txt", sep=";", header=T)

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
data.sm1 <- as.numeric(as.character(data$Sub_metering_1))
data.sm2 <- as.numeric(as.character(data$Sub_metering_2))
data.sm3 <- as.numeric(as.character(data$Sub_metering_3))

par(mfrow=c(1,1))


## setup the plot
plot(data$Datestamp, data.sm1, type="l", col="black", ylab = "Energy sub metering", xlab="", main="")
lines(data$Datestamp, data.sm2, col="red")
lines(data$Datestamp, data.sm3, col="blue")

## display the legend
place <- "topright"
cols <- c("black", "red", "blue")
## NOTE: the '   .' is a fix as per https://class.coursera.org/exdata-002/forum/search?q=legend#11-state-query=legend 
texts <- c("Sub_metering_1   .", "Sub_metering_2   .", "Sub_metering_3   .")
lines <- c(1,1,1)
legend(place, col=cols, texts, lty=lines)

## save the plot
dev.copy(png, file="plot3.png")
dev.off()
