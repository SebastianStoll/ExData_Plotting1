# Reading in the csv-file
data <- read.csv("household_power_consumption.txt", colClasses = "character", sep = ";")

# Subsetting the input data to the required dates and converting
# the Global_active_power column into numeric values
periodData <- subset(data, Date %in% c("1/2/2007", "2/2/2007"))

# Convert required metrics into numeric values and create a date time column
# for a continuous plotting of the x values
periodData$Sub_metering_1 <- as.numeric(periodData$Sub_metering_1)
periodData$Sub_metering_2 <- as.numeric(periodData$Sub_metering_2)
periodData$Sub_metering_3 <- as.numeric(periodData$Sub_metering_3)
periodData$Voltage <- as.numeric(periodData$Voltage)
periodData$Global_reactive_power <- as.numeric(periodData$Global_reactive_power)
periodData$dateTime <- strptime(paste(periodData$Date, periodData$Time, sep = ' '), "%d/%m/%Y %H:%M:%S")

# Open the png device with the required widht/height
# create a 2x2 multiplot
png(file = "plot4.png", width=480, height=480)
par(mfrow = c(2,2))

# plot position upper left
plot(periodData$dateTime, periodData$Global_active_power, pch=".", xlab="", ylab="Global Active Power")
lines(periodData$dateTime, periodData$Global_active_power)

# plot position upper right
plot(periodData$dateTime, periodData$Voltage, pch=".", xlab="datetime", ylab="Voltage")
lines(periodData$dateTime, periodData$Voltage)

# plot position lower left
plot(periodData$dateTime, periodData$Sub_metering_1, pch = '.', xlab="", ylab="Energy sub metering")
lines(periodData$dateTime, periodData$Sub_metering_1, col = "black")
lines(periodData$dateTime, periodData$Sub_metering_2, col = "red")
lines(periodData$dateTime, periodData$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"), lty=c(1,1), bty = "n")

# plot position lower right
plot(periodData$dateTime, periodData$Global_reactive_power, pch=".", xlab="datetime", ylab="Global_reactive_power")
lines(periodData$dateTime, periodData$Global_reactive_power)

# shut down the device
dev.off()