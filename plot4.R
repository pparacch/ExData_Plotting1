#1. Locale Set To English (to replicate the plots)
## How to change local setting on (MAC) OSX Yosemitye version 10.10.2
## In order to have english setting
loc_temp <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "en_GB") 

#2. Load the data set
## Assumption 1 - The dataset "household_power_consumption.txt" is present in the working directory
## Download the zip file containing the dataset and unzip the "household_power_consumption.txt"
## in the same directory where plotN.R (N = 1, 2, 3, 4) scripts are located. This directory
## is the working direcory in R environment when running plotN.R (N = 1, 2, 3, 4) scripts.


## 2.1 Memory Usage Suggestions
## Being a big dataset some tricks are being used (see read.table help)
### Suggestion 1 - Less memory will be used if colClasses is specified 
### Reading the first few row from the dataset in order to get info about the relevan classes
data_part <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, nrows = 10)
data_classes <- sapply(data_part, class)

### Suggestion 2 - Using nrows = 2,075,300 (a midl over-estimate)
### Suggestion 3 - Using comment.char = ""
data_all  <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = data_classes, stringsAsFactors = FALSE, nrows = 2075300, comment.char = "") 

#3. Get data subset connected with the relevant dates
x <- data_all[data_all$Date == "1/2/2007" | data_all$Date == "2/2/2007",]

#4. Add a DateAndTime variable and convert Date from character to a Date format
x$DateAndTime <- strptime(paste(x$Date, x$Time), "%d/%m/%Y %H:%M:%S") #Adding a Date variable
x$Date <- as.Date(x$Date, "%d/%m/%Y") #Change date string to a Date type

##################
## Create Plot 4 #
##################
png("plot4.png", bg = "transparent", width = 480, height = 480, units = "px")
par(mfrow = c(2,2), cex.lab = 1)
plot(x$DateAndTime, x$Global_active_power, col = "black",
     type = "l", ylab = "Global Active Power",
     xlab = "")

plot(x$DateAndTime, x$Voltage, col = "black",
     type = "l", ylab = "Voltage",
     xlab = "datetime")

plot(x$DateAndTime, x$Sub_metering_1, col = "black",
     type = "l", ylab = "Energy sub metering",
     xlab = "")
points(x$DateAndTime, x$Sub_metering_2, col = "red", type = "l")
points(x$DateAndTime, x$Sub_metering_3, col = "blue", type = "l")
legend(cex = 1, bty = "n", "topright", pch = c(NA, NA, NA), lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(x$DateAndTime, x$Global_reactive_power, col = "black",
     type = "l", ylab = "Global_reactive_power",
     xlab = "datetime")
dev.off()

#5. Locale Set BAck To Original
#In order to have return to the original settings for LC_TIME
Sys.setlocale("LC_TIME", loc_temp)
