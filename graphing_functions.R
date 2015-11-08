library(dplyr)

plot.to.file <- function(plot.function, file.name) {
  if (!exists("tidy.household.power.consumption")) {
    source("tidy_data.R")
  }
  
  png(file.name, width=480, height=480)
  plot.function(tidy.household.power.consumption)
  dev.off()
}

plot.global.active.power.hist <- function(household.power.data) {
  global.active.power.in.kilowatts <- household.power.data$Global_active_power
  color <- "red"
  xlabel <- "Global Active Power (kilowatts)"
  main.label <- "Global Active Power"
  hist(global.active.power.in.kilowatts, col = color, xlab = xlabel, main = main.label)
}


plot.energe.sub.metering <- function(household.power.data) {
  household.power.consumption.grouped.by.date.time <- group_by(household.power.data, Date_Time)
  mean.sub.metering.grouped.by.date.time <-
    summarize(
      household.power.consumption.grouped.by.date.time,
      mean_sub_metering_1 = mean(Sub_metering_1, na.rm = T),
      mean_sub_metering_2 = mean(Sub_metering_2, na.rm = T),
      mean_sub_metering_3 = mean(Sub_metering_3, na.rm = T))
  
  times = mean.sub.metering.grouped.by.date.time$Date_Time
  
  ylabel <- "Energy sub metering"
  xlabel <- ""
  max_mean = max(c(mean.sub.metering.grouped.by.date.time$mean_sub_metering_1,
                   mean.sub.metering.grouped.by.date.time$mean_sub_metering_2,
                   mean.sub.metering.grouped.by.date.time$mean_sub_metering_3), na.rm = T)
  
  plot(times, seq_along(times), type = "n", ylab = ylabel, xlab = xlabel, ylim = c(0, max_mean))
  lines(times, mean.sub.metering.grouped.by.date.time$mean_sub_metering_1)
  lines(times,mean.sub.metering.grouped.by.date.time$mean_sub_metering_2, col="red")
  lines(times,mean.sub.metering.grouped.by.date.time$mean_sub_metering_3, col="blue")
  
  legend(
    "topright",
    c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    lty = 1,
    lwd = 2.5,
    col=c("black", "red", "blue"),
    cex = .75)
}

plot.mean.of.variable.against.time <- function(var.key, var.label, data, xlab = "") {
  variable.summary = aggregate(data[[var.key]], by=list(data$Date_Time), FUN=mean)
  plot(variable.summary$Group.1, variable.summary$x, type="n", ylab = var.label, xlab = xlab)
  lines(variable.summary$Group.1, variable.summary$x)
}