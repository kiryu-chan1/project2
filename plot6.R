library(dplyr)
library(ggplot2)
unzip("exdata_data_NEI_data.zip")
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summaryscc_PM25.rds")
str(SCC)
Vehicle <- subset(SCC, grepl("Vehicle", SCC.Level.Two))
scc <- Vehicle$SCC
selected <- filter(NEI, SCC %in% scc)
baltimore <- subset(selected, fips == "24510")
los_angeles <- subset(selected, fips == "06037")
selected <- subset(selected, fips %in% c("24510", "06037"))
final <- mutate(selected, place = recode(fips, "24510" = "Baltimore", "06037" = "Los_angeles"))
final <- transform(final, place = as.factor(final$place))
str(final)
png("plot6.png")
ggplot(final, aes(x = as.factor(as.character(year)), y = Emissions, fill = place)) +
    geom_bar(stat = "identity") +
    facet_wrap(~place) +
    labs(x = "Year", y = "motor vehicle emissions in tons", title = "comparison between Baltimore and Los-angeles")
dev.off()