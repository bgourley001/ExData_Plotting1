#Exploratory Data Analysis
#Course Project 1
#plot1.R

#set stringsAsFactors = FALSE
options(stringsAsFactors = FALSE)

#Load required packages
library(data.table)

#The data file is located in the working directory in the folder 'household_power_consumption'
#File name is 'household_power_consumption.txt'

#The data required is a subset of the full data file, from dates '1/2/2007' to '2/2/2007'
#Analyzing data file using Notepad++, the data required is in rows 66638 to 69518, a total of 2880 rows
#Column headers are in row 1
#read parameters for the data are : skip = 66637, nrows = 2880
#read parameters for the column headers are : nrows = 1

#Read the data file subset
plot1.data <- read.table(file.path("household_power_consumption","household_power_consumption.txt"),
                         skip = 66637, nrows = 2880,sep = ";")

#read the headers and add them to plot1.data
names(plot1.data) <- names(read.table(file.path("household_power_consumption","household_power_consumption.txt"),
                                      nrows = 1,header = TRUE,sep = ";"))

#convert 'Date' column to Date class
plot1.data$Date <- as.Date(plot1.data$Date,"%d/%m/%Y")


#check the data
dim(plot1.data)
head(plot1.data)
tail(plot1.data)

#Plot 1
#screen test
hist(plot1.data$Global_active_power,
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main="Global Active Power")

#create png plot (plot1.png)
png(filename = "plot1.png",width = 480,height = 480)
hist(plot1.data$Global_active_power,
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main="Global Active Power")
dev.off()

