library(dplyr)
library(tidyr)
library(ggplot2)

# unzip downloaded data
unzip("./exdata_data_NEI_data.zip")

# read 2 files using RDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Q4
# Across the United States, how have emissions 
# from coal combustion-related sources changed from 1999–2008?

# Get SCC code for sources that coal combustion related
coal_sources <- SCC[grep("coal",SCC$EI.Sector,ignore.case = TRUE),"SCC"]

# Compute sum of PM2,5 per year per for SCC in coal_sources
Coal_data <- subset(NEI, SCC %in% coal_sources)
Coal_total_PM2_5 <- Coal_data %>% 
  group_by(year) %>% 
  summarize(sum_pm25 = sum(Emissions, na.rm = TRUE))

# Save Plot of sum of PM2.5 per year as PNG
png("plot4.png",  bg = "white")
ggplot(Coal_total_PM2_5, aes(year, sum_pm25)) + geom_line()+ labs(y="Sum of PM25",x="Year", title = "Sum of PM25 for Coal Combustion Related Sources")
dev.off()