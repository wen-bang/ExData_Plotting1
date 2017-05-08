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

# Plot4

par(mfrow=c(2,2)) # set two plots per row and two plots per column

 plot(Data$Date_Time,Data$Global_active_power,ylab="Global Active Power(kilowatts)",type="l",xlab="") # first plot (upper left one)

 plot(Data$Date_Time,Data$Voltage,xlab="datetime",ylab="Voltage",main="",type="l")  # second plot (upper right one)

 with(Data,plot(Date_Time,Sub_metering_1,type="l",xlab="",main="",ylab="Energy sub metering")) # third plot(bottom left one)
 with(Data,lines(Date_Time,Sub_metering_2,col="red")) 
 with(Data,lines(Date_Time,Sub_metering_3,col="blue"))
 legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1 ","Sub_metering_2 ","Sub_metering_3 "),lty=c(1,1), bty="n", cex=.5)
 # remove box of the legend by bty="n"(default "o") and scale the character by cex=.5

 plot(Data$Date_Time,Data$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",main="",type="l") # fourth plot(bottom right one)

 dev.copy(png,"plot4.png", width=480, height=480)
 dev.off()
