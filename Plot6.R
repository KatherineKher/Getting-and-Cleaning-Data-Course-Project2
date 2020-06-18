library(dplyr)
library(tidyr)
library(ggplot2)

# unzip downloaded data
unzip("./exdata_data_NEI_data.zip")

# read 2 files using RDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Q6
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# Get SCC code for from motor vehicle sources
motor_sources <- SCC[grep("motor",SCC$SCC.Level.Three,ignore.case = TRUE),"SCC"]

# Compute sum of PM2,5 per year per for SCC in motor_sources for Baltimore city & Los Angeles
Motor_data <- subset(NEI, SCC %in% motor_sources & fips %in% c("24510", "06037"))
Motor_total_PM2_5 <- Motor_data %>% 
  group_by(year, fips) %>% 
  summarize(sum_pm25 = sum(Emissions, na.rm = TRUE))

# Save Plot of sum of PM2.5 per year as PNG
png("plot6.png",  bg = "white")
ggplot(Motor_total_PM2_5, aes(year, sum_pm25, color=fips)) + geom_line()+ labs(y="Sum of PM25",x="Year", title = "Sum of PM25 for Motor vehicle Sources in Baltimore City Vs. Los Angeles") +scale_colour_discrete(name = "City", label = c("Los Angeles","Baltimore"))
dev.off()