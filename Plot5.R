library(dplyr)
library(tidyr)
library(ggplot2)

# unzip downloaded data
unzip("./exdata_data_NEI_data.zip")

# read 2 files using RDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Q5
# How have emissions from motor vehicle 
# sources changed from 1999–2008 in Baltimore City?

# Get SCC code for from motor vehicle sources
motor_sources <- SCC[grep("motor",SCC$SCC.Level.Three,ignore.case = TRUE),"SCC"]

# Compute sum of PM2,5 per year per for SCC in motor_sources for Baltimore city
Motor_data <- subset(NEI, SCC %in% motor_sources & fips == "24510")
Motor_total_PM2_5 <- Motor_data %>% 
  group_by(year) %>% 
  summarize(sum_pm25 = sum(Emissions, na.rm = TRUE))

# Save Plot of sum of PM2.5 per year as PNG
png("plot5.png",  bg = "white")
ggplot(Motor_total_PM2_5, aes(year, sum_pm25)) + geom_line()+ labs(y="Sum of PM25",x="Year", title = "Sum of PM25 for Motor vehicle Sources in Baltimore City")
dev.off()