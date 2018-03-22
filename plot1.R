#Load the data of the txt file on R
labels <- strsplit(readLines("household_power_consumption.txt", n=1),";")[[1]]
hpc <- read.table("household_power_consumption.txt", header = F, sep = ";", na.strings = "?", 
                  skip = grep("1/2/2007", readLines("household_power_consumption.txt"))[1], 
                  nrows = 2880, col.names = labels)
#paste and transform the date and time variables
DateTime <- strptime(paste(hpc$Date, hpc$Time),"%d/%m/%Y %H:%M:%S")
hpc <- cbind(DateTime,hpc[,3:9])

#Plot
hist(hpc$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

#Copy plot to the png device
dev.copy(png,"plot1.png")
dev.off()