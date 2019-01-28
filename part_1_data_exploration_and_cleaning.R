## install required packages
install.packages("WDI")
install.packages("rworldmap")
install.packages("ggplot2")
install.packages("tidyr")
install.packages("forecast")
install.packages("dplyr")
install.packages("tidyr")
install.packages("gtable")
install.packages("ggpubr")
install.packages("vioplot")
install.packages("DataExplorer")
install.packages("dlookr")
install.packages("naniar")

## load required packages
library(WDI)
library(rworldmap)
library(ggplot2)
library(tidyr)
library(forecast)
library(dplyr)
library(tidyr)
library(gtable)
library(grid)
library(ggpubr)
library(vioplot)
library(DataExplorer)   # for EDA
library(dlookr)
library(naniar)


############################################## Data Exploration: Share of GDP on Infrastructure #########################
dff <- WDI(country = 'all', indicator = "NV.IND.TOTL.ZS",
               start = 1990, end = 2018, extra = TRUE, cache = NULL)

## keep only sub-saharan countries/regions
dff <- dff[grep("Saharan", dff$region),]

summary(dff)

## Create a plot to see distribution of Share of GDP on Infrastructure
gg1 <- ggplot(dff, aes(x = year, y = NV.IND.TOTL.ZS)) + 
  geom_point(colour = "red", size = 2) +
  labs(title = "Distribution of Share of GDP on Infrastructure",
       y = "Share of GDP on Infrastructure", x = "Year")
gg1

for (i in 1) {
  dff[which.max(dff$NY.GDP.DEFL.KD.ZG),]
  row_to_delete <- which.max(dff$NV.IND.TOTL.ZS)
  dff <- dff[-(row_to_delete),]
}


fig <- ggarrange(gg1, ncol = 1, nrow = 1)
fig <- annotate_figure(fig,
                       top = text_grob("Share of GDP on Infrastructure", face = "bold", size = 14))
fig


############################################## Exploring World Bank Data Set #######################################
# Load data for all countries
raw <- WDI(country = 'all', indicator = 'NV.IND.TOTL.ZS', 
           start = 1990, end = 2018, extra = TRUE, cache = NULL)
names(raw)
head(raw)
# Make a plot to see what feature the dataset has
plot_str(raw)