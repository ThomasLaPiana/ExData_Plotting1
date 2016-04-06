#Load in the Data File
raw_dt = fread('household_power_consumption.txt', verbose=TRUE)
#Filter out unneeded data
energy_dt = filter(raw_dt, Date == '1/2/2007'| Date == '2/2/2007')
#Declare the PNG file
png(file='plot1.png',width = 480,height = 480)
#Set X
x = as.integer(energy_dt$Global_active_power)
#Create the histogram with the required params
hist(x,
     breaks = 12,
     xlab = 'Global Active Power (kilowatts)',
     main = 'Global Active Power',
     col = 'red')
#Close out and save the PNG file
dev.off()