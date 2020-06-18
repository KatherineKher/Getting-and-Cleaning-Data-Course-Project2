library(dplyr)
library(tidyr)

# unzip downloaded data
unzip("./exdata_data_NEI_data.zip")

# read 2 files using RDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Q2 
# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

# Compute sum of PM2,5 per year for flips == "24510"
Baltimore_data <- subset(NEI, fips == "24510")
Baltimore_total_PM2_5 <- Baltimore_data %>% 
  group_by(year) %>% 
  summarize(total_pm25 = sum(Emissions, na.rm = TRUE))

# Save Plot of sum of PM2.5 per year as PNG
png("plot2.png",  bg = "white")
plot(Baltimore_total_PM2_5$year, Baltimore_total_PM2_5$total_pm25, type = "l", xlab = "Year", ylab = "Sum of PM2.5", main = "Sum of PM2.5 for Baltimore City")
dev.off()