# Load file

if(!file.exists("exdata-data-household_power_consumption.zip")) {
        temp <- tempfile()
        download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
        file <- unzip(temp)
        unlink(temp)
}

# Read only 1/2/2007 and 2/2/2007 data into R using readLines

Lines <- readLines(file)

subL  <- grep( paste(c("1/2/2007","2/2/2007"), collapse = "|"), substr(Lines,1,8))
# grep more than 1 string using paste. substr extracts first 8 characters in each line -- subL are number of lines with two dates

colnames <- c("Date","Time", "Global_active_power", "Global_reactive_power", "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
# now subL does not include first line -- column names. So we will name columns later

Data <- read.table(text=Lines[subL], header=T, sep=";", col.names = colnames, na.strings = "?") 

# Plot2

Data <- Data[complete.cases(Data),]  # remove NAs in the data

Data$Date <- as.Date(Data$Date, "%d/%m/%Y") # format date to Date type

Date_Time <- paste(Data$Date, Data$Time) # combine date and time before plotting

Date_Time <- setNames(Date_Time, "Date_Time") # name the new column

Data <- cbind(Data,Date_Time)  # combine data and new column

Data$Date_Time <- as.POSIXct(Date_Time)   # format the date and time

plot(Data$Date_Time,Data$Global_active_power,ylab="Global Active Power(kilowatts)",type="l",xlab="")

dev.copy(png,"plot2.png", width=480, height=480) # copy the plot to png file
dev.off()