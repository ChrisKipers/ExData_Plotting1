# Plots 4 graphs in a 2 by 2 arangement to plot4.png.

source('graphing_functions.R')

PlotToFile(function(data) {
  par(mfrow=c(2,2))
  PlotMeanOfVariableAgainstTime('Global_active_power', 'Global Active Power (kilowatts)', data)
  PlotMeanOfVariableAgainstTime('Voltage', 'Voltage', data)
  PlotEnergySubMetering(data)
  PlotMeanOfVariableAgainstTime('Global_reactive_power', 'Global_reactive_power', data)
}, 'plot4.png')