
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

# plot2
par(mfcol=c(1, 1))

plot2 <- function() {
    with(subdf,
         plot(DateTime,
              Global_active_power,
              type="l",
              xlab="",
              ylab="Global Active Power (kilowatts)"))
}

#plot on screen
plot2()

# send plot to png
png("plot2.png", width=480, height=480)
plot2()
dev.off()

