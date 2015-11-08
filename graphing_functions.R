# Functions used to plot different graphs of the household power consumption
# data.

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
  color <- 'red'
  xlabel <- 'Global Active Power (kilowatts)'
  main.label <- 'Global Active Power'
  hist(household.power.data$Global_active_power,
       col = color,
       xlab = xlabel,
       main = main.label)
}


PlotEnergySubMetering <- function(household.power.data) {
  # Plots a line graph of Sub_metering_1, Sub_metering_2, and Submetering_4
  # against time.
  # Args:
  #   household.power.data: The tidy household power data
  ylabel <- 'Energy sub metering'
  xlabel <- ''
  max_submetering_value <- max(c(household.power.data$Sub_metering_1,
                                 household.power.data$Sub_metering_2,
                                 household.power.data$Sub_metering_3),
                               na.rm = T)
  
  plot(household.power.data$Date_Time,
       seq_along(household.power.data$Date_Time),
       type = 'n',
       ylab = ylabel,
       xlab = xlabel,
       ylim = c(0, max_submetering_value))
  
  lines(household.power.data$Date_Time,
        household.power.data$Sub_metering_1)
  lines(household.power.data$Date_Time,
        household.power.data$Sub_metering_2,
        col = 'red')
  lines(household.power.data$Date_Time,
        household.power.data$Sub_metering_3,
        col = 'blue')
  
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
  plot(data$Date_Time,
       data[[var.key]],
       type='n',
       ylab = var.label,
       xlab = xlab)
  lines(data$Date_Time, data[[var.key]])
}
