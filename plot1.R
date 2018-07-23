data = read.csv("household_power_consumption.txt", header = TRUE, sep = ";",  colClasses = rep("character", 9))
dates = as.Date(data[, 'Date'], format="%d/%m/%Y");
minDate = as.Date("2007-02-01");
maxDate = as.Date("2007-02-02");

powerRaw = as.numeric(data[dates >= minDate & dates <= maxDate, "Global_active_power"])
power = powerRaw[!is.na(powerRaw)]

png (filename = "figure/plot1.png", width = 480, height = 480)
hist(power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")
dev.off()