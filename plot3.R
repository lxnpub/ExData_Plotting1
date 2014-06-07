
localzip <- "local_household_power_consumption.zip"
localdatafile <- "household_power_consumption.txt"
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists(localdatafile)) {
    if (!file.exists(localzip)) {
        if (Sys.info()['sysname'] == "Windows") {
            setInternet2(TRUE)
            download.file(fileUrl, destfile=localzip)
        }
        else {
            download.file(fileUrl, destfile=localzip, method="curl")
        }
    }
    unzip(localzip)
    if (!file.exists(localdatafile)) {
        stop("Can get extract household_power_consumption.txt from zip file")
    }
}

colcls <- c("character", "character",
            "numeric", "numeric", "numeric",
            "numeric", "numeric", "numeric",
            "numeric")
df <- read.table(localdatafile, header=T, sep=";", na.strings="?",
                     stringsAsFactors=F, colClasses=colcls)

subdf <- subset(df, Date=="1/2/2007" | Date=="2/2/2007")
subdf$DateTime <- as.POSIXct(paste(subdf$Date, subdf$Time), format="%d/%m/%Y %H:%M:%S")


# plot3
par(mfcol=c(1, 1))

plot3 <- function() {
    with(subdf, {
        plot(DateTime, Sub_metering_1,
             type="l", col="black",
             xlab="", ylab="Energy sub metering")
        lines(DateTime, Sub_metering_2, col="red")
        lines(DateTime, Sub_metering_3, col="blue")
        legend("topright",  
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               col=c("black", "red", "blue"),
               lty=c(1,1,1), 
               lwd=c(1,1,1))
    })
}

#plot on screen
plot3()

# send plot to png
png("plot3.png", width=480, height=480)
plot3()
dev.off()


