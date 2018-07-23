data = read.csv("household_power_consumption.txt", header = TRUE, sep = ";",  colClasses = rep("character", 9))
dates = as.Date(data[, 'Date'], format="%d/%m/%Y");
minDate = as.Date("2007-02-01");
maxDate = as.Date("2007-02-02");

filteredData = data[dates >= minDate & dates <= maxDate, ];
powerRaw = as.numeric(filteredData[, "Global_active_power"])
power = powerRaw[!is.na(powerRaw)]
time = as.POSIXlt (sprintf ("%s %s", filteredData[, 'Date'], filteredData[, 'Time']), format="%d/%m/%Y %H:%M:%S");

png (filename = "figure/plot2.png", width = 480, height = 480)
plot(time, power, type = "l", ylab = "Global Active Power (kilowatts)", col = "black", main = "")
dev.off()
