# This file downloads and tidys the household power consumption data from UCI.
# The tidying process involves filtering out all observations except for those
# made on 2/2/2007 or 2/1/2007, converting numeric fields to numeric values
# and adding a Date_Time field.

library(dplyr)
library(lubridate)

file.name.in.zip <- 'household_power_consumption.txt'
file.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# If the file does not exist, download the file and unzip it into the current
# directory with the file name 'household_power_consumption.txt".
if (!file.exists(file.name.in.zip)) {
  temp <- tempfile()
  download.file(file.url, temp)
  unzip(temp, files=c(file.name.in.zip))
  unlink(temp)
}

# The dates of the observations we want to analyze.
target.dates <- c(mdy('2/2/2007'), mdy('2/1/2007'))

raw.household.power.consumption <- read.csv('household_power_consumption.txt',
                                            sep = ';',
                                            na.strings = '?')

tidy.household.power.consumption <- raw.household.power.consumption %>%
  mutate(Date_Time = dmy_hms(paste(Date, Time)),
         Date = dmy(Date), Time = hms(Time),
         Global_active_power = as.numeric(Global_active_power),
         Global_reactive_power = as.numeric(Global_reactive_power),
         Sub_metering_1 = as.numeric(Sub_metering_1),
         Sub_metering_2 = as.numeric(Sub_metering_2),
         Sub_metering_3 = as.numeric(Sub_metering_3),
         Voltage = as.numeric(Voltage)) %>%
  filter(Date %in% target.dates)

# Remove the raw data.
rm(raw.household.power.consumption)
