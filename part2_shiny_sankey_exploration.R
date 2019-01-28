library(WDI)
library(dplyr)
library(varhandle)
library(networkD3)
library(magrittr)

########################################################################################
## GDP Growth % (NY.GDP.MKTP.KD.ZG)
########################################################################################

gdp_growth <- WDI(country = 'all', indicator = "NY.GDP.MKTP.KD.ZG",
                  start = 1990, end = 2018, extra = TRUE, cache = NULL)
## keep only sub-saharan countries/regions
gdp_growth <- gdp_growth[grep("Saharan", gdp_growth$region),]
afr <- unique(gdp_growth$country)
length(afr) #47
head(afr)

########################################################################################
## Climatescope - Mapping the Global Frontiers for Clean Energy Investment (2013 - 2017)
########################################################################################

cm <- read.csv("climatescope-full-2017.csv")
head(cm)
str(cm)
NROW(cm) #4081
table(cm$name.en_aa) #each 53 (contains Indian states)
length(unique(cm$name.en_aa)) #77

cm$name.en_aa <- as.character(cm$name.en_aa)
cm <- filter(cm, name.en_aa %in% afr)
NROW(cm1) #901
table(cm$name.en_aa)
length(unique(cm$name.en_aa)) #17

unique(cm$name.en_var)
unique(cm$type_var)

sum(is.na(cm$X2017))  #0
sum(is.na(cm$X2016))  #0
sum(is.na(cm$X2015))  #17
sum(is.na(cm$X2014))  #17

cm_2016 <- cm
cm_2016$X2014 <- NULL
cm_2016$X2015 <- NULL
cm_2016$X2017 <- NULL

cm_2017 <- cm
cm_2017$X2014 <- NULL
cm_2017$X2015 <- NULL
cm_2017$X2016 <- NULL

write.csv(cm_2016, file = "climatescope-full-2017-ONLY-AFR-2016.csv", row.names = FALSE)
write.csv(cm_2017, file = "climatescope-full-2017-ONLY-AFR-2017.csv", row.names = FALSE)

########################################################################################
## GDP (NY.GDP.MKTP.CD)
########################################################################################

gdp <- WDI(country = 'all', indicator = "NY.GDP.MKTP.CD", start = 1990, end = 2018, 
           extra = TRUE, cache = NULL)
## keep only sub-saharan and world aggregates
## WLD - world
## TSS - sub-saharan africa
gdp_aggr <- gdp[grep("^WLD$|^TSS$", gdp$iso3c),]

wld <- gdp_aggr[gdp_aggr$iso3c == "WLD", ]
tss <- gdp_aggr[gdp_aggr$iso3c == "TSS", ]

keeps <- c("year","iso3c", "NY.GDP.MKTP.CD")
wld <- wld[keeps]
tss <- tss[keeps]

new_names <- c("Year", "Region", "GDP")
colnames(wld) <- new_names
colnames(tss) <- new_names

gdpf <- merge(wld, tss, by = "Year")
col_names <- c("Year", "WLD", "GDP_WLD", "TSS", "GDP_TSS")
colnames(gdpf) <- col_names

gdpf$Percent <- 0

for(i in 1:nrow(gdpf)) {
  gdpf$Percent[i] <- (gdpf$GDP_TSS[i]/gdpf$GDP_WLD[i]) * 100
}

write.csv(gdpf, file = "gdp_contribution_TSS.csv", row.names = FALSE)

########################################################################################
## Employment to population ratio, 15+, total (%) (modeled ILO estimate)
## https://data.worldbank.org/indicator/SL.EMP.TOTL.SP.ZS
########################################################################################

emp <- WDI(country = 'all', indicator = "SL.EMP.TOTL.SP.ZS", 
           start = 1990, end = 2018, extra = TRUE, cache = NULL)
afr_emp <- emp[grep("Saharan", emp$region),]

NROW(emp)
NROW(afr_emp)

gdp <- WDI(country = 'all', indicator = "NY.GDP.MKTP.CD", start = 1990, end = 2018, 
           extra = TRUE, cache = NULL)
afr_gdp <- gdp[grep("Saharan", gdp$region),]

keeps_emp <- c("year","iso3c", "country", "income", "SL.EMP.TOTL.SP.ZS")
afr_emp <- afr_emp[keeps_emp]
new_names <- c("Year", "Region", "Country", "Income", "Employment")
colnames(afr_emp) <- new_names
no_data <- afr_emp[!complete.cases(afr_emp$Employment),]

keeps_gdp <- c("year","iso3c", "country", "income", "NY.GDP.MKTP.CD")
afr_gdp <- afr_gdp[keeps_gdp]
new_names <- c("Year", "Region", "Country", "Income", "GDP")
colnames(afr_gdp) <- new_names

gdp_emp <- merge(afr_emp, afr_gdp, by = c("Year", "Region"))
gdp_emp$Income.y <- NULL
gdp_emp$Country.y <- NULL
names(gdp_emp)[names(gdp_emp) == "Income.x"] <- "Income"
names(gdp_emp)[names(gdp_emp) == "Country.x"] <- "Country"

write.csv(gdp_emp, file = "gdp_emp_TSS_countries.csv", row.names = FALSE)


### Vulnerable Employment

emp <- WDI(country = 'all', indicator = "SL.EMP.VULN.ZS", 
           start = 1990, end = 2018, extra = TRUE, cache = NULL)
afr_emp <- emp[grep("Saharan", emp$region),]

NROW(emp)
NROW(afr_emp)

gdp <- WDI(country = 'all', indicator = "NY.GDP.MKTP.CD", start = 1990, end = 2018, 
           extra = TRUE, cache = NULL)
afr_gdp <- gdp[grep("Saharan", gdp$region),]

keeps_emp <- c("year","iso3c", "country", "income", "SL.EMP.VULN.ZS")
afr_emp <- afr_emp[keeps_emp]
new_names <- c("Year", "Region", "Country", "Income", "Employment")
colnames(afr_emp) <- new_names
no_data <- afr_emp[!complete.cases(afr_emp$Employment),]

keeps_gdp <- c("year","iso3c", "country", "income", "NY.GDP.MKTP.CD")
afr_gdp <- afr_gdp[keeps_gdp]
new_names <- c("Year", "Region", "Country", "Income", "GDP")
colnames(afr_gdp) <- new_names

gdp_emp <- merge(afr_emp, afr_gdp, by = c("Year", "Region"))
gdp_emp$Income.y <- NULL
gdp_emp$Country.y <- NULL
names(gdp_emp)[names(gdp_emp) == "Income.x"] <- "Income"
names(gdp_emp)[names(gdp_emp) == "Country.x"] <- "Country"

write.csv(gdp_emp, file = "gdp_vul_emp_TSS_countries.csv", row.names = FALSE)

########################################################################################
## Commodity Trade Statistics
## https://www.kaggle.com/unitednations/global-commodity-trade-statistics
########################################################################################


real <- read.csv("commodity_trade_statistics_data.csv")

tr <- real
NROW(tr) #8225871
names(tr) 

af <- WDI(country = 'all', indicator = "NY.GDP.MKTP.CD", start = 1990, end = 2018, 
          extra = TRUE, cache = NULL)
af <- af[grep("Saharan", af$region),]
cons <- unique(af$country)

tr <- tr[tr$country_or_area %in% cons,]
NROW(tr) #819237

tr <- tr[tr$year >= 1990,]
NROW(tr) #819237

tr <- tr %>% 
  group_by(country_or_area, year, flow) %>% 
  summarise(trade_usd = sum(trade_usd))
NROW(tr) #1513

write.csv(tr, file = "trade_for_d3.csv", row.names = FALSE)

unique(tr$category)

vec <- c(unique(unfactor(tr$country_or_area)), unique(unfactor(tr$flow)))

nodes <- data.frame(node = seq(0, length(vec)-1), 
                    name = vec)
nodes$name <- unfactor(nodes$name)
links <- tr[c("country_or_area", "flow", "trade_usd")]
colnames(links) <- c("source", "target", "value")
links$source <- unfactor(links$source)
links$target <- unfactor(links$target)

links$source <- nodes[match(links$source, nodes$name), 1]
links$target <- nodes[match(links$target , nodes$name), 1]

sankey <- sankeyNetwork(Links = links, Nodes = nodes, 
                        Source = 'source', 
                        Target = 'target', 
                        Value = 'value', 
                        NodeID = 'name',
                        units = 'USD')

sankey

