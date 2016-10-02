#####   R code for performing plot4  ######
#ExData_Plotting_Project1
#Dataset: Electric power consumption

#first: Loading and preparing the Data  

setwd("~/Desktop/Project1_Plotting Data")
EPCdata <- read.table("household_power_consumption.txt",  sep = ";", header = T,  na.strings = "?")
View(EPCdata)
dim(EPCdata)
library(dplyr)  
EPC_frame <- tbl_df(EPCdata)  
rm(EPCdata)  

#Using filter function to select only data from dates 1/2/2007 and 2/2/2007

EPC <- filter(EPC_frame, Date == "1/2/2007" | Date == "2/2/2007")
names(EPC)

EPC  <- mutate(EPC , Date_Time1  = paste(Date, Time, sep = " "))  
EPC$Date_Time1 <- strptime(EPC$Date_Time1, "%d/%m/%Y %H:%M:%S")
str(EPC) 

##### Data ready for Plotting #####
#### PLot 4 : Four Time plots of Energy sub metering with overall plot size: (width x hight) = (480 x 480) pixels

par(mfrow=c(2,2)) # preparing the window to
#plot_A   
  with(EPC,  plot(Date_Time1, Global_active_power, type = "l",  ylab = "Global Active Power", xlab = ""))

#plot_C   
  with(EPC,  plot(Date_Time1, Voltage, type = "l",  ylab = "Voltage", xlab = "datetime"))

#plot_B   
  plot(EPC$Date_Time1, EPC$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
  points(EPC$Date_Time1, EPC$Sub_metering_2, type = "l", col = "red")
  points(EPC$Date_Time1, EPC$Sub_metering_3, type = "l", col = "blue")
    legend("topright", lty = c(1,1,1), lwd = c(2,2,2),  col = c("black", "red", "blue"),
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n") 

#plot_D  
  with(EPC,  plot(Date_Time1, Global_reactive_power, type = "l",  ylab = "Global_reactive_power", xlab = "datetime"), ylim = c(0, 0.5) )

dev.copy(png, file= "plot4.png", width=480, height=480) #copying plot4 to a png file  
dev.off()
dir() # plot4.png is now stored at working directory
