## read the data
data <- read.table("data.txt", sep=";", header=T, na.strings="?")
dates = paste(data$Date, data$Time)
dates <- strptime(dates, "%d/%m/%Y %H:%M:%S")
data$Datestamp <- dates
startdate <- strptime(c("2007/02/01 00:00:00"), "%Y/%m/%d %H:%M:%S" )
enddate <- strptime(c("2007/02/02 23:59:59"), "%Y/%m/%d %H:%M:%S" )
data <- subset(data, Datestamp >= startdate)
data <- subset(data, Datestamp <= enddate)

hist_nums <- as.numeric(as.character(data$Global_active_power))
hist(hist_nums, col="red", breaks=12, xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.copy(png, file="plot1.png")
dev.off()
