library(dplyr)
library(tidyr)

# unzip downloaded data
unzip("./exdata_data_NEI_data.zip")

# read 2 files using RDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Q1 
# Have total emissions from PM2.5 decreased in the United States 
# from 1999 to 2008? Using the base plotting system, 
# make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

# Compute sum of PM2,5 per year
total_PM2_5 <- NEI %>% 
  group_by(year) %>% 
  summarize(total_pm25 = sum(Emissions, na.rm = TRUE))
# Save Plot of sum of PM2.5 per year as PNG
png("plot1.png",  bg = "white")
plot(total_PM2_5$year, total_PM2_5$total_pm25, type = "l", xlab = "Year", ylab = "Sum of PM2.5", main = "Sum of PM2.5 for entire dataset")
dev.off()