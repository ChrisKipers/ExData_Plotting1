# Functions used to plot different graphs of the household power consumption
# data.
library(dplyr)

PlotToFile <- function(plot.function, file.name) {
  # Invokes a plotting function with the household power consumption data
  # in the context of the file to which the plot will be drawn.
  #
  # Args:
  #   plot.function: Function that will plot the household power consumption data
  #   file.name: The name of the png file that the plot will be drawn to
  
  # Ensure data is available 
  if (!exists('tidy.household.power.consumption')) {
    source('tidy_data.R')
  }
  
  png(file.name, width = 480, height = 480)
  plot.function(tidy.household.power.consumption)
  dev.off()
}

PlotGlobalActivePowerHist <- function(household.power.data) {
  # Plots a red histogram of the Global Active Power
  # Args:
  #   household.power.data: The tidy household power data
  global.active.power.in.kilowatts <- household.power.data$Global_active_power
  color <- 'red'
  xlabel <- 'Global Active Power (kilowatts)'
  main.label <- 'Global Active Power'
  hist(global.active.power.in.kilowatts, col = color, xlab = xlabel, main = main.label)
}


PlotEnergySubMetering <- function(household.power.data) {
  # Plots a line graph of Sub_metering_1, Sub_metering_2, and Submetering_4
  # against time.
  # Args:
  #   household.power.data: The tidy household power data
  household.power.consumption.grouped.by.date.time <-
    group_by(household.power.data, Date_Time)
  
  mean.sub.metering.grouped.by.date.time <-
    summarize(
      household.power.consumption.grouped.by.date.time,
      mean_sub_metering_1 = mean(Sub_metering_1, na.rm = T),
      mean_sub_metering_2 = mean(Sub_metering_2, na.rm = T),
      mean_sub_metering_3 = mean(Sub_metering_3, na.rm = T))
  
  times <- mean.sub.metering.grouped.by.date.time$Date_Time
  
  ylabel <- 'Energy sub metering'
  xlabel <- ''
  max_mean <- max(c(mean.sub.metering.grouped.by.date.time$mean_sub_metering_1,
                   mean.sub.metering.grouped.by.date.time$mean_sub_metering_2,
                   mean.sub.metering.grouped.by.date.time$mean_sub_metering_3), na.rm = T)
  
  plot(times, seq_along(times), type = 'n', ylab = ylabel, xlab = xlabel, ylim = c(0, max_mean))
  lines(times, mean.sub.metering.grouped.by.date.time$mean_sub_metering_1)
  lines(times,mean.sub.metering.grouped.by.date.time$mean_sub_metering_2, col = 'red')
  lines(times,mean.sub.metering.grouped.by.date.time$mean_sub_metering_3, col = 'blue')
  
  legend(
    'topright',
    c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
    lty = 1,
    lwd = 2.5,
    col = c('black', 'red', 'blue'),
    cex = 0.75)
}

PlotMeanOfVariableAgainstTime <- function(var.key, var.label, data, xlab = '') {
  # Plots a variable of the data against the Date_time varabile of the data.
  # Args:
  #   var.key: The name of the variable
  #   var.label: The label for the variable
  #   data: The data to use for the graph
  #   xlab: The x label for the graph
  variable.summary <-
    aggregate(data[[var.key]], by=list(data$Date_Time), FUN=mean)
  plot(variable.summary$Group.1,
       variable.summary$x,
       type='n',
       ylab = var.label,
       xlab = xlab)
  lines(variable.summary$Group.1, variable.summary$x)
}