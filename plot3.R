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

# Plot3

with(Data,plot(Date_Time,Sub_metering_1,type="l",xlab="",main="",ylab="Energy sub metering")) 

with(Data,lines(Date_Time,Sub_metering_2,col="red")) 

with(Data,lines(Date_Time,Sub_metering_3,col="blue"))

legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1 ","Sub_metering_2 ","Sub_metering_3 "),lwd=c(1,1),lty=c(1,1)) # set legend

dev.copy(png,"plot3.png", width=480, height=480)
dev.off()