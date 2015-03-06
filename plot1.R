# Reading in the csv-file
data <- read.csv("household_power_consumption.txt", colClasses = "character", sep = ";")

# Subsetting the input data to the required dates and converting
# the Global_active_power column into numeric values
periodData <- subset(data, Date %in% c("1/2/2007","2/2/2007"))
periodData$Global_active_power <- as.numeric(periodData$Global_active_power)

# Open the png device with the required widht/height, create the plot
# and shut down the device again
png(file = "plot1.png", width=480, height=480)
with(periodData, hist(Global_active_power, col= "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", ylim = c(0,1200)))
dev.off()