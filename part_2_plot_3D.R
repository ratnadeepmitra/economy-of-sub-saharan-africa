setwd("~/ANLY503/Project/Part2")
# Read Data
library(readr)
contra_birth_gdp <- read_csv("Data/contra_and_gdp.csv")

View(contra_birth_gdp)
library(htmlwidgets)
library(plotly)
library(threejs)
library(igraph)
library(htmlwidgets)
library(dplyr)

packageVersion('plotly')

#Credentials
Sys.setenv("plotly_username"="sooeun67")
Sys.setenv("plotly_api_key"="ygxskRGTqtvpdoCyLbtP")

#Filter out 
contra_birth_gdp <- contra_birth_gdp %>% filter(date == 2016)
# Remove missing values
is.na(contra_birth_gdp)
contra_birth_gdp <- na.omit(contra_birth_gdp)
is.na(contra_birth_gdp)

# Add income level dataset
income <- read_csv("Data/income_level.csv")
income <-
income %>%
  select(Country, income)
names(income) <- c("country", "income_level")

# Merge two dataframes
contra_birth_gdp <- merge(contra_birth_gdp, income, by="country")
head(contra_birth_gdp)

# Change to percentile
contra_birth_gdp$contraceptive_percent <- contra_birth_gdp$contraceptive_prevalence/100
contra_birth_gdp$birth_rate_per_10000 <- contra_birth_gdp$birth_rate_per_1000/100

# create palette
#income_levels = c("High income", "Upper middle income", "Lower middle income", "Low income")
#df$income_level <- factor(df$income_level, levels = income_levels)

#pal <- c("#1f77b4", "#2ca02c", "#ff7f0e", "#d62728")
#pal <- setNames(pal, income_levels)


# 3D Rotatable plot
p2 <- plot_ly(contra_birth_gdp, x = ~contraceptive_percent, y = ~birth_rate_per_10000, z = ~gdp_growth, 
             color = ~income_level, colors = c('#1f77b4', '#2ca02c', '#ff7f0e') ) %>%
  add_markers() %>%
  layout(
    title = "3D Plot of Birth Rate, Birth Control, and GDP Growth colored by income level",
    scene = list(xaxis = list(title = 'Contraceptive Prevalence'),
                      yaxis = list(title = 'Birth Rate per 10000'),
                      zaxis = list(title = 'GDP Growth')))
p2

saveWidget(as_widget(p2), file="3D_rotatable_birth_GDP.html")
