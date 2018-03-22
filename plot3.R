#Load the data of the txt file on R
labels <- strsplit(readLines("household_power_consumption.txt", n=1),";")[[1]]
hpc <- read.table("household_power_consumption.txt", header = F, sep = ";", na.strings = "?", 
                  skip = grep("1/2/2007", readLines("household_power_consumption.txt"))[1], 
                  nrows = 2880, col.names = labels)
#paste and transform the date and time variables
DateTime <- strptime(paste(hpc$Date, hpc$Time),"%d/%m/%Y %H:%M:%S")
hpc <- cbind(DateTime,hpc[,3:9])

#Plot
plot(hpc$DateTime, hpc$Sub_metering_1, type="n", ylab = "Energy sub metering", xlab = "")
lines(hpc$DateTime, hpc$Sub_metering_1)
lines(hpc$DateTime, hpc$Sub_metering_2, col = "red")
lines(hpc$DateTime, hpc$Sub_metering_3, col = "blue")
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), lty=1, cex=0.5, adj=c(0, 0.6),
       )

#Copy plot to the png device
dev.copy(png,"plot3.png")
dev.off()