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
library(XML)
library(reshape2)
library(ggplot2)
library(ggfortify)
library(ggthemes)


## using world bank indicator NY.GDP.MKTP.KD.ZG
## https://data.worldbank.org/indicator/NY.GDP.MKTP.KD.ZG
## GDP Growth (Annual %)
## ---------------------
gdp_growth <- WDI(country = 'all', indicator = "NY.GDP.MKTP.KD.ZG",
                  start = 1990, end = 2018, extra = TRUE, cache = NULL)

## keep only sub-saharan and world aggregates
## WLD - world
## TSS - sub-saharan africa
africa <- gdp_growth[grep("^WLD$|^TSS$", gdp_growth$iso3c),]

NROW(gdp_growth)
NROW(africa)
t <- table(africa$iso3c)
t[c("WLD","TSS")]
v <- sapply(split(africa$NY.GDP.MKTP.KD.ZG, africa$iso3c), function(x) sum(is.na(x)))
v[c("WLD","TSS")]

write.csv(africa, file = "Avg_Annual_GDP_Growth.csv", row.names = FALSE)
## ---------------------



## GDP Deflator
## using world bank indicator NY.GDP.DEFL.KD.ZG
## https://data.worldbank.org/indicator/NY.GDP.DEFL.KD.ZG
## Inflation, GDP deflator (annual %)
## -------------
inf_gdp <- WDI(country = 'all', indicator = "NY.GDP.DEFL.KD.ZG",
               start = 1990, end = 2018, extra = TRUE, cache = NULL)

## keep only sub-saharan countries/regions
inf_gdp <- inf_gdp[grep("Saharan", inf_gdp$region),]

summary(inf_gdp)

## check for outliers
gg1 <- ggplot(inf_gdp, aes(x = year, y = NY.GDP.DEFL.KD.ZG)) + 
      geom_point(colour = "red", size = 2) +
      labs(title = "Before removing outliers",
           y = "GDP Deflator", x = "Year")
gg1

for (i in 1) {
  inf_gdp[which.max(inf_gdp$NY.GDP.DEFL.KD.ZG),]
  row_to_delete <- which.max(inf_gdp$NY.GDP.DEFL.KD.ZG)
  inf_gdp <- inf_gdp[-(row_to_delete),]
}

## check data after removing outliers
gg2 <- ggplot(inf_gdp, aes(x = year, y = NY.GDP.DEFL.KD.ZG)) + 
  geom_point(colour = "darkgreen", size = 2) +
  labs(title = "After removing outliers",
       y = "GDP Deflator", x = "Year")

gg2

fig <- ggarrange(gg1, gg2, ncol = 1, nrow = 2)
fig <- annotate_figure(fig,
                top = text_grob("Inflation and Income - GDP Deflator", face = "bold", size = 14))
fig

write.csv(inf_gdp, file = "Inflation_GDP_Deflator.csv", row.names = FALSE)
## ---------------------



## Consumer Price Index
## using world bank indicator FP.CPI.TOTL.ZG
## https://data.worldbank.org/indicator/FP.CPI.TOTL.ZG
## Inflation, consumer prices (annual %)
## ---------------------
inf_cpi <- WDI(country = 'all', indicator = "FP.CPI.TOTL.ZG", 
               start = 1990, end = 2018, extra = TRUE, cache = NULL)

## keep only sub-saharan countries/regions
inf_cpi <- inf_cpi[grep("Saharan", inf_cpi$region),]

## check for NAs
summary(inf_cpi) #198 CPI NAs
inf_cpi[!complete.cases(inf_cpi$FP.CPI.TOTL.ZG), ]

## drop NAs
inf_cpi <- inf_cpi[complete.cases(inf_cpi$FP.CPI.TOTL.ZG), ]
summary(inf_cpi)

## check for outliers
gg1 <- ggplot(inf_cpi, aes(x = year, y = FP.CPI.TOTL.ZG)) + 
  geom_point(colour = "red", size = 2) +
  labs(title = "Before removing outliers",
       y = "Consumer Price Index", x = "Year")
gg1

## remove outliers
for (i in 1:2) {
  inf_cpi[which.max(inf_cpi$FP.CPI.TOTL.ZG),]
  row_to_delete <- which.max(inf_cpi$FP.CPI.TOTL.ZG)
  inf_cpi <- inf_cpi[-(row_to_delete),]
}

## check data after removing outliers
gg2 <- ggplot(inf_cpi, aes(x = year, y = FP.CPI.TOTL.ZG)) + 
  geom_point(colour = "darkgreen", size = 2) +
  labs(title = "Before removing outliers",
       y = "Consumer Price Index", x = "Year")
gg2

fig <- ggarrange(gg1, gg2, ncol = 1, nrow = 2)
fig <- annotate_figure(fig,
                       top = text_grob("Inflation and Income - Consumer Price Index", face = "bold", size = 14))
fig

write.csv(inf_cpi, file = "Inflation_Consumer_Price_Index.csv", row.names = FALSE)
## ---------------------



## using world bank indicator SL.EMP.TOTL.SP.ZS
## https://data.worldbank.org/indicator/SL.EMP.TOTL.SP.ZS
## Employment to population ratio, 15+, total (%) (modeled ILO estimate)
## ---------------------
emp <- WDI(country = 'all', indicator = "SL.EMP.TOTL.SP.ZS", 
               start = 1990, end = 2018, extra = TRUE, cache = NULL)

## keep only sub-saharan countries/regions
afr_emp <- emp[grep("Saharan", emp$region),]

NROW(emp)
NROW(afr_emp)
t <- table(afr_emp$iso3c)
t
t[t>0]

write.csv(afr_emp, file = "Employment_To_Population_Ratio.csv", row.names = FALSE)

## keep only sub-saharan and world aggregates
## WLD - world
## TSS - sub-saharan africa
afr_agg <- emp[grep("^WLD$|^TSS$", emp$iso3c),]

NROW(emp)
NROW(afr_agg)
t <- table(afr_agg$iso3c)
t[c("WLD","TSS")]
v <- sapply(split(afr_agg$SL.EMP.TOTL.SP.ZS, afr_agg$iso3c), function(x) sum(is.na(x)))
v[c("WLD","TSS")]

## check for outliers
Regions_xlab <- c("Sub-Saharan Africa", "World")
qplot(x = iso3c, y = SL.EMP.TOTL.SP.ZS, data = afr_agg, geom = c("boxplot","jitter"), fill = iso3c) +
  labs(title = "Employment to population ratio (World and Sub-Saharan Africa)",
       subtitle = "Check for outliers",
       y = "Employment to population ratio", x = "Region") +
  theme(legend.position = "none") +
  scale_x_discrete(labels = Regions_xlab) +
  scale_fill_manual(values = c("#CC6666", "#9999CC"))

write.csv(afr_agg, file = "Employment_To_Population_Ratio_Aggr.csv", row.names = FALSE)
## ---------------------



## using world bank indicator SL.EMP.VULN.ZS
## https://data.worldbank.org/indicator/SL.EMP.VULN.ZS
## Vulnerable employment, total (% of total employment) (modeled ILO estimate)
## ---------------------
vul <- WDI(country = 'all', indicator = "SL.EMP.VULN.ZS",
               start = 1990, end = 2018, extra = TRUE, cache = NULL)

## keep only sub-saharan and world aggregates
## WLD - world
## TSS - sub-saharan africa
vul_agg <- vul[grep("^WLD$|^TSS$", vul$iso3c),]

NROW(vul)
NROW(vul_agg)
t <- table(vul_agg$iso3c)
t[c("WLD","TSS")]
v <- sapply(split(vul_agg$SL.EMP.VULN.ZS, vul_agg$iso3c), function(x) sum(is.na(x)))
v[c("WLD","TSS")]

## check for outliers
Regions_xlab <- c("Sub-Saharan Africa", "World")
ggplot(vul_agg, aes(x = iso3c, y = SL.EMP.VULN.ZS)) +
  geom_violin(aes(fill = iso3c)) + 
  geom_boxplot(width = 0.2) +
  labs(title = "Vulnerable employment (World and Sub-Saharan Africa)",
       subtitle = "Check for outliers",
       y = "Vulnerable employment", x = "Region") +
  theme(legend.position = "none") +
  scale_x_discrete(labels = Regions_xlab) +
  scale_fill_manual(values = c("#CC6666", "#9999CC"))

write.csv(vul_agg, file = "Vulnerable_Employment.csv", row.names = FALSE)
## ---------------------



## using world bank indicator SL.EMP.VULN.ZS
## https://data.worldbank.org/indicator/SL.EMP.VULN.ZS
## Vulnerable employment, total (% of total employment) (modeled ILO estimate)
## ---------------------
ind <- WDI(country = 'all', indicator = "NV.IND.TOTL.ZS",
           start = 1990, end = 2018, extra = TRUE, cache = NULL)
write.csv(ind, file = "Infrastructure_Share_GDP.csv", row.names = FALSE)


