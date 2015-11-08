source("graphing_functions.R")

plot.to.file(function(data) {
  par(mfrow=c(2,2))
  plot.mean.of.variable.against.time("Global_active_power", "Global Active Power (kilowatts)", data)
  plot.mean.of.variable.against.time("Voltage", "Voltage", data)
  plot.energe.sub.metering(data)
  plot.mean.of.variable.against.time("Global_reactive_power", "Global_reactive_power", data)
}, 'plot4.png')