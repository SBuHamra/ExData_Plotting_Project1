#####   R code for performing plot2  ######
#ExData_Plotting_Project1
#Dataset: Electric power consumption

#first: Loading and preparing the Data  
#setting a working directory "Project1_Plotting Data", the data set was unzipped in the above directory

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
#Using mutate function in one command line to create new variable
EPC  <- mutate(EPC , Date_Time1  = paste(Date, Time, sep = " ")) #   no need to define a variable as dataset$var with mutate
EPC$Date_Time1 <- strptime(EPC$Date_Time1, "%d/%m/%Y %H:%M:%S")
str(EPC) 

##### Data ready for Plotting #####
#### PLot 2 : Time plot of "Global Active Power (kilowatts)" with plot size: (width x hight) = (480 x 480) pixels

plot2 <- with(EPC,  plot(Date_Time1, Global_active_power, type = "l", xlab = "" ,  ylab = "Global Active Power (kilowatts)"))
dev.copy(png, file= "plot2.png", width=480, height=480) #copying plot2 to a png file  
dev.off()
dir() # plot2.png is now stored at working directory
