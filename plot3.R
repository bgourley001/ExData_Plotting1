#Exploratory Data Analysis
#Course Project 1
#plot3.R

#set stringsAsFactors = FALSE
options(stringsAsFactors = FALSE)

#Load required packages
library(data.table)
library(dplyr)

#####################################################################################################
# Declare Functions
#####################################################################################################
#Function downloadFile
downloadFile <- function(url,dest.file,method) {
    download.file(url,dest.file,method)
}

#The data file is located in the working directory in the folder 'household_power_consumption'
#File name is 'household_power_consumption.txt'

#####################################################################################################
# Download household_power_consumption.zip & extract the contents (requires curl)
#####################################################################################################
#Check to see if household_power_consumption.zip exists in the working folder
#If it exists, then don't download and unzip it again
#To create a fresh dataset, delete 'household_power_consumption.zip' and the 'household_power_consumption" folder
#then run the script again
dest.file <- "household_power_consumption.zip"
if(!file.exists(dest.file)) {
    print(paste("Downloading household_power_consumption.zip - Please wait..."))
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    method="curl" 
    downloadFile(url,dest.file,method)
    #unzip Dataset
    unzip(dest.file,exdir = "household_power_consumption")
    print(paste("Download Complete at ",Sys.time()))
} else {
    print(paste("household_power_consumption.zip exists - skipping download"))
}

###################################################################################################################
# Read in the data
###################################################################################################################
#The data required is a subset of the full data file, from dates '1/2/2007' to '2/2/2007'
#Analyzing data file using Notepad++, the data required is in rows 66638 to 69518, a total of 2880 rows
#Column headers are in row 1
#read parameters for the data are : skip = 66637, nrows = 2880, sep = ";"
#read parameters for the column headers are : nrows = 1

#Read the data file subset
plot3.data <- read.table(file.path("household_power_consumption","household_power_consumption.txt"),
                         skip = 66637, nrows = 2880,sep = ";")

#read the headers and add them to plot2.data
names(plot3.data) <- names(read.table(file.path("household_power_consumption","household_power_consumption.txt"),
                                      nrows = 1,header = TRUE,sep = ";"))

###################################################################################################################
# Clean up the data and prepare it for plotting
###################################################################################################################
#convert 'Date' column to Date class
plot3.data$Date <- as.Date(plot3.data$Date,"%d/%m/%Y")

#combine dates and times & add column to data set
date.times <- with(plot3.data,
                   strptime(paste(Date,Time),"%Y-%m-%d %H:%M:%S",tz="UTC")
)

plot3.data <- cbind(plot3.data,date.times)

####################################################################################################################
#check the data
####################################################################################################################
dim(plot3.data)
head(plot3.data)
tail(plot3.data)

####################################################################################################################
#create the plot : plot3
####################################################################################################################
#screen test
with(plot3.data,plot(date.times,Sub_metering_1, type = "l",xlab = "",ylab = "Energy sub metering"))
with(plot3.data,lines(date.times,Sub_metering_2,type = "l",col="red"))
with(plot3.data,lines(date.times,Sub_metering_3,type = "l",col="blue"))
legend(x = "topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = c(1,1),col = c("black","red","blue"))

#create png plot (plot3.png)
png(filename = "plot3.png",width = 480,height = 480)
with(plot3.data,plot(date.times,Sub_metering_1, type = "l",xlab = "",ylab = "Energy sub metering"))
with(plot3.data,lines(date.times,Sub_metering_2,type = "l",col="red"))
with(plot3.data,lines(date.times,Sub_metering_3,type = "l",col="blue"))
legend(x = "topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = c(1,1),col = c("black","red","blue"))
dev.off()

