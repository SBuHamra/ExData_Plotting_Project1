#####   R code for performing plot1  ######
#ExData_Plotting_Project1
#Dataset: Electric power consumption
#First: Loading and preparing the Data  

#setting a working directory "Project1_Plotting Data" 
setwd("~/Desktop/Project1_Plotting Data")

#####Loading & unzipping data #####
if(!file.exists("exdata-data-household_power_consumption.zip")) {
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  Myfile <- unzip(temp)
  unlink(temp)
}

EPCdata <- read.table(Myfile,  sep = ";", header = T,  na.strings = "?")
#EPCdata <- read.table("household_power_consumption.txt",  sep = ";", header = T,  na.strings = "?") #if already unzipped in working directory
View(EPCdata)
dim(EPCdata)

library(dplyr) #A package  with efficient and easy functions (arrange, filter, select, mutate and rename) to deal with data frames
EPC_frame <- tbl_df(EPCdata) # To load data in package Data Frame format
rm(EPCdata) # To avoid confusion remove original data

#Using filter function to select only data from dates 1/2/2007 and 2/2/2007
 
EPC <- filter(EPC_frame, Date == "1/2/2007" | Date == "2/2/2007")
names(EPC)
#Using mutate function in one command line to create new variable
EPC  <- mutate(EPC , Date_Time1  = paste(Date, Time, sep = " ")) #   no need to define a variable as dataset$var with mutate
EPC$Date_Time1 <- strptime(EPC$Date_Time1, "%d/%m/%Y %H:%M:%S")
str(EPC) 

##### Data ready for Plotting #####
#### PLot 1 : Histogram of Global_Active_Power with plot size: (width x hight) = (480 x 480) pixels

plot1 <- with(EPC, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))
#Using the dev.copy command instead of the unaccurate opration of direct copy of a plot to a file    
dev.copy(png, file= "plot1.png", width=480, height=480) #This will copy the created plot to a png file in the working dir  
dev.off() # Important to close the device 

dir() # plot1.png is now stored at working directory