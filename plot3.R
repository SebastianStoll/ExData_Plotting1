# Reading in the csv-file
data <- read.csv("household_power_consumption.txt", colClasses = "character", sep = ";")

# Subsetting the input data to the required dates and converting
periodData <- subset(data, Date %in% c("1/2/2007", "2/2/2007"))

# Convert submetering int numeric value 
# and removal of potential NAs
periodData$Sub_metering_1 <- as.numeric(periodData$Sub_metering_1)
periodData$Sub_metering_2 <- as.numeric(periodData$Sub_metering_2)
periodData$Sub_metering_3 <- as.numeric(periodData$Sub_metering_3)
cleanPeriodData <- complete.cases(periodData$Sub_metering_1, periodData$Sub_metering_2, periodData$Sub_metering_3)
periodData <- periodData[cleanPeriodData,]

# create a date time column for the continuous plotting of x values
periodData$dateTime <- strptime(paste(periodData$Date, periodData$Time, sep = ' '), "%d/%m/%Y %H:%M:%S")

# Open the png device with the required widht/height, create the plot
# and shut down the device again
png(file = "plot3.png", width=480, height=480)
plot(periodData$dateTime, periodData$Sub_metering_1, pch = '.', xlab="", ylab="Energy sub metering")
lines(periodData$dateTime, periodData$Sub_metering_1, col = "black")
lines(periodData$dateTime, periodData$Sub_metering_2, col = "red")
lines(periodData$dateTime, periodData$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"), lty=c(1,1))
dev.off()