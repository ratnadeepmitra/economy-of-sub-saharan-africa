setwd("~/ANLY503/Project/Part2")
# Read Data
library(readr)
library(shiny)
library(tm)
library(wordcloud)
library(memoise)
library(shiny)
library(tm)
library(wordcloud)
library(memoise)
library(SnowballC)
library(RColorBrewer)
library(WDI)
library(dplyr)

# Load dataset
trade <- read_csv("Data/commodity_trade_statistics_data.csv")
head(trade)
NROW(trade) #8225871
names(trade)

# filter Sub-saharan countries
af <- WDI(country = 'all', indicator = "NY.GDP.MKTP.CD", start = 1990, end = 2018, 
          extra = TRUE, cache = NULL)
af <- af[grep("Saharan", af$region),]
cons <- unique(af$country)
trade <- trade[trade$country_or_area %in% cons,]

# Filter out 
trade <- trade %>% filter(year == 2016) %>% select(flow, trade_usd, category)
import <- trade %>% filter(flow == "Import") %>% select(trade_usd, category)
export <- trade %>% filter(flow == "Export")

# Aggregate(sum)
import_sum <- aggregate(import$trade_usd, by=list(category=import$category), FUN=sum)
is.na(import_sum)
import_sum <- na.omit(import_sum)

export_sum <- aggregate(export$trade_usd, by=list(category=export$category), FUN=sum)
is.na(export_sum)
export_sum <- na.omit(export_sum)

merged <- merge(x = import_sum, y = export_sum, by = "category")
write.csv(merged, "import_export_sum.csv")


import <- trade %>% filter(flow == "Import") %>% select(trade_usd, category)
# Rename category descriptions.
renamed <- read_csv("part_2_data_trade_rename.csv") %>% select(category, import_sum, export_sum)
import_sum <- renamed %>% select(category, import_sum)
export_sum <- renamed %>% select(category, export_sum)
# imports wordcloud
import_wordcloud <-
  wordcloud(words = import_sum$category, freq = import_sum$import_sum, min.freq = 1,
          random.order=FALSE, rot.per=0.3, scale=c(4, 0.3),
          random.color=FALSE, colors = brewer.pal(8, "Dark2"))


# exports wordcloud
export_wordcloud <-
  wordcloud(words = export_sum$category, freq = export_sum$export_sum, min.freq = 1,
          random.order=FALSE, rot.per=0.3,scale=c(4, 0.3),
          random.color=FALSE, colors = brewer.pal(8, "Dark2"))


















