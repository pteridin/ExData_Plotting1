library(lubridate)
library(tidyverse)
library(Cairo)

# Read and prepare the data
if(!file.exists("household_power_consumption_short.txt"))
{
  df <- readr::read_csv2("household_power_consumption.txt")
  df <- df %>% 
    mutate(Date = as.Date(Date, format="%d/%m/%Y"),
           Global_active_power = as.numeric(Global_active_power),
           Global_reactive_power = as.numeric(Global_reactive_power),
           Global_intensity = as.numeric(Global_intensity),
           Sub_metering_1 = as.numeric(Sub_metering_1),
           Sub_metering_2 = as.numeric(Sub_metering_2),
           Sub_metering_3 = as.numeric(Sub_metering_3)) %>% 
    
    
    filter(Date == "2007-02-01" | Date == '2007-02-02')
  
  write.csv2(df, "household_power_consumption_short.txt", row.names = F)
} else
  df <- read.csv2("household_power_consumption_short.txt")


df$Datetime <- as.POSIXct(paste(df$Date, df$Time))

# plotting
png("plot3.png")
plot(df$Datetime, df$Sub_metering_1, type = "l", 
     xlab = "", ylab = "Energy sub metering")
lines(df$Datetime, df$Sub_metering_2, col="red")
lines(df$Datetime, df$Sub_metering_3, col="blue")
dev.off()