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


## using world bank indicator NY.GDP.MKTP.KD.ZG
## https://data.worldbank.org/indicator/NY.GDP.MKTP.KD.ZG
## GDP Growth (Annual %)
afr <- read.csv(file = "Avg_Annual_GDP_Growth.csv", header = TRUE, sep = ",")

## data preparation (for legends)
afr_subset <- afr
afr_subset$region <- NULL
afr_subset$Region[afr_subset$iso3c == "TSS"]  <- "Sub-Saharan Africa"
afr_subset$Region[afr_subset$iso3c == "WLD"]  <- "World" 

theme_set(theme_bw())

## draw plot
ggplot(afr_subset, aes(x = year, y = NY.GDP.MKTP.KD.ZG, colour = Region)) +
  geom_point() + 
  geom_line() +
  scale_color_manual(values=c("#CC6666", "#9999CC")) +
  xlab("Year") +
  ylab("Average annual GDP growth (%)") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
  scale_x_continuous(breaks = seq(1960, 2017, 3)) +
  labs(subtitle = "Africa vs World", 
       title = "Average Annual GDP Growth %")



## using world bank indicator FP.CPI.TOTL.ZG
## https://data.worldbank.org/indicator/FP.CPI.TOTL.ZG
## Inflation, consumer prices (annual %)
cpi <- read.csv(file = "Inflation_Consumer_Price_Index.csv", header = TRUE, sep = ",")

cpi$income <- factor(cpi$income , levels = c("High income", "Upper middle income", 
                                             "Lower middle income", "Low income"))

## draw plot
ggplot(cpi, aes(x = year, y = country)) + 
  geom_point(aes(col = income, size = FP.CPI.TOTL.ZG)) + 
  labs(subtitle = "Consumer Price Index", 
       x = "Year", 
       y = "Country",
       title = "Inflation (%)",
       size = "CPI",
       colour = "Income Level")  +
  scale_color_manual(values=c("blue", "chartreuse3", "orange", "red"))



## using world bank indicator SL.EMP.TOTL.SP.ZS
## https://data.worldbank.org/indicator/SL.EMP.TOTL.SP.ZS
## Employment to population ratio, 15+, total (%) (modeled ILO estimate)
emp_aggr <- read.csv(file = "Employment_To_Population_Ratio_Aggr.csv", header = TRUE, sep = ",")

## data preparation (for legends)
emp_aggr_subset <- emp_aggr
emp_aggr_subset$region <- NULL
emp_aggr_subset$Region[emp_aggr_subset$iso3c == "TSS"]  <- "Sub-Saharan Africa"
emp_aggr_subset$Region[emp_aggr_subset$iso3c == "WLD"]  <- "World"

theme_set(theme_classic())

## Plot
ggplot(emp_aggr_subset, aes(SL.EMP.TOTL.SP.ZS)) +
  geom_density(aes(fill = factor(Region)), alpha = 0.8) + 
  scale_fill_manual(values = c("#CC6666", "#9999CC")) +
  labs(title = "Employment to population ratio, 15+, total (%)", 
       subtitle = "Africa vs World",
       x = "Employment to population ratio, 15+, total (%)",
       y = "Density",
       fill = "Region")
  


