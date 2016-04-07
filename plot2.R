#Require the needed libs
require(data.table)
require(dplyr)

#Read in as datatable, explicitly stating classes to increase performance
raw_dt = fread('household_power_consumption.txt', 
               colClasses = c('character','character','float','float','float','float','float','float','float'))

#Filter down to the dates we need
raw_energy_dt = filter(raw_dt, Date == '1/2/2007'| Date == '2/2/2007')

#Create a new correct column for datetime
raw_datetime = paste(raw_energy_dt$Date,raw_energy_dt$Time)
datetime = strptime(raw_datetime,format='%d/%m/%Y %H:%M:%S')
energy_dt = cbind(raw_energy_dt,datetime)

#Set the X & Y variables
x = energy_dt$datetime
y = as.numeric(energy_dt$Global_active_power)

#Create the plot
png(file='plot2.png',width = 480,height = 480)
plot(x, y,
     type = 'l',
     xlab = '',
     ylab = 'Global Active Power (kilowatts)',
     col = 'red')
dev.off()