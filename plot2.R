library("data.table")
getwd()
#the working directory is in D folder and hence I had to cut paste the plot from their to the git folder

#Reading data into a dataframe
DATA <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# removing Scientific Notation from showing
DATA[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# POSIXct date
DATA[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filtering for 2007-02-01 and 2007-02-02
DATA <- DATA[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width=480, height=480)

## Plot 2
plot(x = DATA[, dateTime]
     , y = DATA[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
