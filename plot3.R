install.packages("lubridate")
library(lubridate)

dataset <- read.csv2("household_power_consumption.txt")
dataset <- transform(dataset,Date = dmy(Date))
fil_by_date <- dataset[dataset[,1] > dmy("31/1/2007") & dataset[,1] < dmy("3/2/2007"),]
fil_by_date <- transform(fil_by_date, as.Date(Date))
fil_dt <- fil_by_date
fil_dt[,dim(fil_dt)[2]+1] <- ymd_hms(paste(as.character(fil_dt[,1]),as.character(fil_dt[,2])))
names(fil_dt)[10] <- "datetime"
fil_dt <- transform(fil_dt,Sub_metering_1 = as.numeric(as.character(Sub_metering_1)))
fil_dt <- transform(fil_dt,Sub_metering_2 = as.numeric(as.character(Sub_metering_2)))
fil_dt <- transform(fil_dt,Sub_metering_3 = as.numeric(as.character(Sub_metering_3)))

png(filename = "plot3.png", height = 480 , width = 480)
with(fil_dt,plot(datetime,Sub_metering_1,xlab = "", ylab = "Energy sub metering",col="black",type="l"))
lines(fil_dt$datetime,fil_dt$Sub_metering_2,col="red")
lines(fil_dt$datetime,fil_dt$Sub_metering_3,col="blue")
legend("topright",lty = 1, c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"))
dev.off()
