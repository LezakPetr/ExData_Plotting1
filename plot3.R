data = read.csv("household_power_consumption.txt", header = TRUE, sep = ";",  colClasses = rep("character", 9))
dates = as.Date(data[, 'Date'], format="%d/%m/%Y");
minDate = as.Date("2007-02-01");
maxDate = as.Date("2007-02-02");
filteredData = data[dates >= minDate & dates <= maxDate, ];

meteringRaw = as.matrix (filteredData[, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")])
complete = complete.cases(meteringRaw)
metering = meteringRaw[complete, ]
time = as.POSIXlt (sprintf ("%s %s", filteredData[complete, 'Date'], filteredData[complete, 'Time']), format="%d/%m/%Y %H:%M:%S");

draw <- function (column, color) {
  points(time, metering[, column], type = "l", col = color)
}

png (filename = "figure/plot3.png", width = 480, height = 480)
plot(time, apply(metering, 1, max), type = "n", ylab = "Global Active Power (kilowatts)", col = "black", main = "")

draw ("Sub_metering_1", "black")
draw ("Sub_metering_2", "red")
draw ("Sub_metering_3", "blue")

legend ("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
