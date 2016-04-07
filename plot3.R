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
y = energy_dt$Sub_metering_1
v = energy_dt$Sub_metering_2
z = energy_dt$Sub_metering_3

#Create the plot
png(file='plot3.png',width = 480,height = 480)
plot(x, y,
     type = 'l',
     xlab = '',
     ylab = 'Energy sub metering',
     col = 'red')

lines(x,y,col="black")
lines(x,v,col='red')
lines(x,z,col='blue')

legend('topright',names(energy_dt)[7:9],col=c('black','red','blue'),lty=1)
dev.off()




