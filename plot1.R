library("data.table")
getwd()
#the working directory is in D folder and hence I had to cut paste the plot from their to the git folder

#Reading file data
DATA <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# removing scientific notification
DATA[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

#Date Column into Date Type
DATA[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filtering for 2007-02-01 and 2007-02-02
DATA <- DATA[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## Plot 1
hist(DATA[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()
