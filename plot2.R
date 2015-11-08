# Plots the Global active power against time to plot2.png

source('graphing_functions.R')

PlotToFile(function(data) {
  PlotMeanOfVariableAgainstTime('Global_active_power',
                                'Global Active Power (kilowatts)',
                                data)
}, 'plot2.png')
