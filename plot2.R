# Reading in the csv-file
data <- read.csv("household_power_consumption.txt", colClasses = "character", sep = ";")

# Subsetting the input data to the required dates and converting
periodData <- subset(data, Date %in% c("1/2/2007", "2/2/2007"))

# Convert global active power into numeric values 
# and remove potential NA values
periodData$Global_active_power <- as.numeric(periodData$Global_active_power)
cleanPeriodData <- complete.cases(periodData$Global_active_power)
periodData <- periodData[cleanPeriodData,]

# Create a date time column for a continuous plotting of the x values
periodData$dateTime <- strptime(paste(periodData$Date, periodData$Time, sep = ' '), "%d/%m/%Y %H:%M:%S")

# Open the png device with the required widht/height, create the plot
png(file = "plot2.png", width=480, height=480)
plot(periodData$dateTime, periodData$Global_active_power, pch=".", xlab="", ylab="Global Active Power (kilowatts)")
lines(periodData$dateTime, periodData$Global_active_power)

# shut down the device again
dev.off()