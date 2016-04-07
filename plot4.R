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



png(file='plot4.png',width = 480,height = 480)

#Set it to a 2x2 Plot Grid
par(mfrow=c(2,2))

#Set the X & Y variables
x = energy_dt$datetime
y = as.numeric(energy_dt$Global_active_power)

#Create the first plot
plot(x, y,
     type = 'l',
     xlab = '',
     ylab = 'Global Active Power',
     col = 'black')

#Set the X & Y Variables
x = energy_dt$datetime
y = energy_dt$Voltage

#Create the second plot
plot(x,y,
     type='l',
     xlab='datetime',
     ylab='Voltage')


#Set the X & Y variables
x = energy_dt$datetime
y = energy_dt$Sub_metering_1
v = energy_dt$Sub_metering_2
z = energy_dt$Sub_metering_3

#Create the third plot
plot(x, y,
     type = 'l',
     xlab = '',
     ylab = 'Energy sub metering',
     col = 'red')

lines(x,y,col="black")
lines(x,v,col='red')
lines(x,z,col='blue')

legend('topright',names(energy_dt)[7:9],col=c('black','red','blue'),lty=1)

#Set X & Y values
x = energy_dt$datetime
y= energy_dt$Global_reactive_power

#Create the fourth plot
plot(x,y,
     type='l',
     xlab='datetime',
     ylab='Global_reactive_power')

dev.off()




