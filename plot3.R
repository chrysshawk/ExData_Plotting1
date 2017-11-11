plot3 <- function(){
     # Downloading and extracting file data if not already present
     if(!file.exists("./data")){
          message("Data not yet downloaded, will download first...")
          dir.create("./data")
          fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
          download.file(fileURL, dest="dataset.zip", mode="wb", method = "auto") 
          unzip ("dataset.zip", exdir = "./data/")
          file.remove("dataset.zip") # removing the archive
     }
     
     # Reading file to dataframe
     message("Reading data file...")
     dataDF <- read.table(file = "./data/household_power_consumption.txt", header = TRUE,
                          sep = ";", na.strings = "?")
     powerDF <- subset(dataDF, Date %in% c("1/2/2007", "2/2/2007"))
     
     # Merging date and time and converting to POSIXct
     powerDF$Date <- as.POSIXct(with(powerDF, paste(Date, Time)), format ="%d/%m/%Y %H:%M:%S")
     powerDF <- powerDF[,-2] # Dropping Time column
     
     #####PLOT 3
     
     # Creating PNG device
     png(file = "plot3.png", width = 480, height = 480, units = "px", 
         bg = "transparent")
     
     # Creating line plot
     plot(powerDF$Date, powerDF$Sub_metering_1, type = "l", 
          xlab = "", ylab = "Energy sub metering")
     lines(powerDF$Date, powerDF$Sub_metering_2, col = "red")
     lines(powerDF$Date, powerDF$Sub_metering_3, col = "blue")
     legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
            lty = c(1,1), col = c("Black", "Red", "Blue"))
     
     # Closing device
     dev.off()
     
     message("Success! Plot saved as plot3.png to working directory.")
     
}