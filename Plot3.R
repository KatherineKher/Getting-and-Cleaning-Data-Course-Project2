library(dplyr)
library(tidyr)
library(ggplot2)

# unzip downloaded data
unzip("./exdata_data_NEI_data.zip")

# read 2 files using RDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Q3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# Compute sum of PM2,5 per year per type for flips == "24510"
Baltimore_data <- subset(NEI, fips == "24510")
Baltimore_total_PM2_5 <- Baltimore_data %>% 
  group_by(year, type) %>% 
  summarize(sum_pm25 = sum(Emissions, na.rm = TRUE))

# Save Plot of sum of PM2.5 per year as PNG
png("plot3.png",  bg = "white")
ggplot(Baltimore_total_PM2_5, aes(year, sum_pm25,color=type)) + geom_line()+ labs(y="Sum of PM25",x="Year", title = "Sum of PM25 for Baltimore City per Type")
dev.off()