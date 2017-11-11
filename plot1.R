plot1 <- function(){
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
     
     #####PLOT 1
     
     # Creating PNG device
     png(file = "plot1.png", width = 480, height = 480, units = "px",
         bg = "transparent")
     
     # Creating histogram of Global active power
     hist(powerDF$Global_active_power, col = "red", main = "Global Active Power", 
          xlab = "Global Active Power (kilowatts)")
     
     # Closing device
     dev.off()
     
     message("Success! Plot saved as plot1.png to working directory.")

}