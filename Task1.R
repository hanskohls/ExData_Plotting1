data <- read.table("data.txt", sep=";", header=T)
dates = paste(data$Date, data$Time)
dates <- strptime(dates, "%d/%m/%Y %H:%M:%S")
data$Datestamp <- dates
startdate <- strptime(c("2007/02/01 00:00:00"), "%Y/%m/%d %H:%M:%S" )
enddate <- strptime(c("2007/02/02 23:59:59"), "%Y/%m/%d %H:%M:%S" )
dataf <- subset(data, Datestamp >= startdate)
dataf <- subset(dataf, Datestamp <= enddate)
