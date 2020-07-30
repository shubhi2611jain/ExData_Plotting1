library("data.table")
getwd()
#the working directory is in D folder and hence I had to cut paste the plot from their to the git folder

#Readind data into a datframe
DATA <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# removing Scientific Notation
DATA[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date
DATA[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filtering for 2007-02-01 and 2007-02-02
DATA <- DATA[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot3.png", width=480, height=480)

# Plot 3
plot(DATA[, dateTime], DATA[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(DATA[, dateTime], DATA[, Sub_metering_2],col="red")
lines(DATA[, dateTime], DATA[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()
