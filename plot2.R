source("graphing_functions.R")

plot.to.file(function(data) {
  plot.mean.of.variable.against.time("Global_active_power", "Global Active Power (kilowatts)", data)
}, 'plot2.png')