install.packages("lubridate")
library(lubridate)

dataset <- read.csv2("household_power_consumption.txt")
dataset <- transform(dataset,Date = dmy(Date))
fil_by_date <- dataset[dataset[,1] > dmy("31/1/2007") & dataset[,1] < dmy("3/2/2007"),]
fil_by_date <- transform(fil_by_date, as.Date(Date))
fil_dt <- fil_by_date
fil_dt[,dim(fil_dt)[2]+1] <- ymd_hms(paste(as.character(fil_dt[,1]),as.character(fil_dt[,2])))
fil_dt <- transform(fil_dt,Global_Active_Power = as.numeric(as.character(Global_active_power)))
names(fil_dt)[10] <- "datetime"
png(filename = "plot2.png",height = 480, width = 480)
with(fil_dt,plot(datetime,Global_Active_Power,type="l",xlab = "",ylab = "Global Active Power"))
dev.off()
