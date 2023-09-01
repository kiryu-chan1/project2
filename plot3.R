library(ggplot2)
unzip("exdata_data_NEI_data.zip")
NEI <- readRDS("summaryscc_PM25.rds")
nei_sub <- subset(NEI, fips == "24510")
nei_sub <- transform(nei_sub, type = as.factor(nei_sub$type))
nei_sub <- transform(nei_sub, year = as.factor(as.character(nei_sub$year)))
png("plot3.png")
ggplot(nei_sub, aes(x = year, y = Emissions, fill = type)) +
    facet_grid(~type) +
    geom_bar(aes( y= Emissions), stat = "identity") +
    labs(xlab = "Year", ylab = "Emission in tons", title = "Emission per type over the years") +
    theme(axis.text.x = element_text(angle = 45), plot.title = element_text(hjust = 0.5))
dev.off()