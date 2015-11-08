library(dplyr)
library(lubridate)

file.name.in.zip <- 'household_power_consumption.txt'
file.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists(file.name.in.zip)) {
  temp <- tempfile()
  download.file(file.url, temp)
  unzip(temp, files=c(file.name.in.zip))
  unlink(temp)
}

target.dates <- c(mdy('2/2/2007'), mdy('2/1/2007'))
raw.household.power.consumption <- read.csv('household_power_consumption.txt', sep = ';', na.strings = '?')
tidy.household.power.consumption <- raw.household.power.consumption %>%
  mutate(
    Date_Time = dmy_hms(paste(Date, Time)),
    Date = dmy(Date), Time = hms(Time),
    Global_active_power = as.numeric(Global_active_power),
    Global_reactive_power = as.numeric(Global_reactive_power),
    Sub_metering_1 = as.numeric(Sub_metering_1),
    Sub_metering_2 = as.numeric(Sub_metering_2),
    Sub_metering_3 = as.numeric(Sub_metering_3),
    Voltage = as.numeric(Voltage)) %>%
  filter(Date %in% target.dates)

rm(raw.household.power.consumption)