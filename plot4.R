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

draw2 <- function (column, axisY) {
  filteredData = data[dates >= minDate & dates <= maxDate, ];
  powerRaw = as.numeric(filteredData[, column])
  power = powerRaw[!is.na(powerRaw)]
  time = as.POSIXlt (sprintf ("%s %s", filteredData[, 'Date'], filteredData[, 'Time']), format="%d/%m/%Y %H:%M:%S");
  
  plot(time, power, type = "l", ylab = axisY, col = "black", main = "")
}

png (filename = "figure/plot4.png", width = 480, height = 480)
par (mfrow = c(2, 2), mar = c(4, 4, 2, 2))


draw2("Global_active_power", "Global Active Power")
draw2("Voltage", "Voltage")

plot(time, apply(metering, 1, max), type = "n", ylab = "Global Active Power (kilowatts)", col = "black", main = "")

draw ("Sub_metering_1", "black")
draw ("Sub_metering_2", "red")
draw ("Sub_metering_3", "blue")

legend ("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


draw2("Global_reactive_power", "Global Reactive Power")

dev.off()
