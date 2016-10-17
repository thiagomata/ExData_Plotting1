###
# 1. Load the necessary libraries
###

# clean the memory
rm( list=ls() )

# load library
library(data.table)
Sys.setenv(LANG = "en")
Sys.setlocale("LC_TIME", "en_US")

###
# 2. Download the zip data file ( if necessary )
###

projectPath = "~/Projects/ExData_Plotting1"
powerConsumptionFile = "household_power_consumption.txt"
powerConsumptionUrl  = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Set the local file dir the current path
setwd( projectPath )

# if the data file not exists
if( ! file.exists( powerConsumptionFile ) ) {
  

###
# 3. Extract the data file from the zip
###

  # download the zip file into a temp file
  temp <- tempfile()
  download.file( powerConsumptionUrl, temp )
  
  # unzip the content from the zip file
  unzip( temp, files = powerConsumptionFile )
  
  # remove the zip file
  unlink(temp)
}

###
# 4. Read the data from the file
###

# load the power consumption data
powerConsumptionData <- fread( powerConsumptionFile, na.strings = "?", stringsAsFactors = FALSE)

###
# 5. Convert the date into the data
###

# read the date as d/m/Y
powerConsumptionData[,`:=`( Date = as.Date(Date, format="%d/%m/%Y") ),]

###
# 6. Filter the date  of the data into the range 02/01/2007 and 02/02/2007
###

# filter into the range
powerConsumptionData <- powerConsumptionData[Date >= "2007-02-01" & Date <= "2007-02-02",,]

# read date as posix
powerConsumptionData[,`:=`( Datetime = as.POSIXct(paste(Date, Time)) ),]

###
# 7. Plot the Chart of the Global Active Power
###

par(mar=c(2,5,2,1));

# Create the histogram of the global power active
plot(Global_active_power ~ Datetime,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)",
     data = powerConsumptionData)
###
# 8. Saves the Plot
###

# save into the plot1.png
dev.copy(png, file="plot2.png", height=405, width=405)
dev.off()

###
# 9. Clear the memory
###

# clear the memory
rm( list=ls() )
