setwd("~/ANLY503/Project/Part2")
# Read Data
library(readr)
infra_index <- read_csv("Data/Infrastructure_Index_2.csv")
View(infra_index)
library(htmlwidgets)
library(plotly)
library(threejs)
library(igraph)
library(htmlwidgets)
packageVersion('plotly')

head(infra_index)

is.na(infra_index)
infra_index <- na.omit(infra_index)
is.na(infra_index)

#Credentials
Sys.setenv("plotly_username"="sooeun67")
Sys.setenv("plotly_api_key"="ygxskRGTqtvpdoCyLbtP")


head(infra_index)
#infra_index <- as.data.frame(infra_index)
p <- infra_index %>%
  plot_ly(
    type = 'scatter', 
    x = ~year, 
    y = ~score,
    text = ~country,
    hoverinfo = 'text',
    mode = 'markers',
    
    marker = list(
      color = 'rgb(17, 157, 255)',
      size = 20,
      line = list(
        color = 'rgb(231, 99, 250)',
        width = 2
      )
    ),
      
    transforms = list(
      list(
        type = 'filter',
        target = ~country,
        operation = '=',
        value = unique(infra_index$country)[1]
      )
    )) %>% layout(
      updatemenus = list(
        list(
          type = 'dropdown',
          active = 0,
          buttons = list(
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[1]),
                 label = unique(infra_index$country)[1]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[2]),
                 label = unique(infra_index$country)[2]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[3]),
                 label = unique(infra_index$country)[3]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[4]),
                 label = unique(infra_index$country)[4]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[5]),
                 label = unique(infra_index$country)[5]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[6]),
                 label = unique(infra_index$country)[6]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[7]),
                 label = unique(infra_index$country)[7]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[8]),
                 label = unique(infra_index$country)[8]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[9]),
                 label = unique(infra_index$country)[9]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[10]),
                 label = unique(infra_index$country)[10]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[11]),
                 label = unique(infra_index$country)[11]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[12]),
                 label = unique(infra_index$country)[12]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[13]),
                 label = unique(infra_index$country)[13]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[14]),
                 label = unique(infra_index$country)[14]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[15]),
                 label = unique(infra_index$country)[15]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[16]),
                 label = unique(infra_index$country)[16]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[17]),
                 label = unique(infra_index$country)[17]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[18]),
                 label = unique(infra_index$country)[18]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[19]),
                 label = unique(infra_index$country)[19]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[20]),
                 label = unique(infra_index$country)[20]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[21]),
                 label = unique(infra_index$country)[21]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[22]),
                 label = unique(infra_index$country)[22]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[23]),
                 label = unique(infra_index$country)[23]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[24]),
                 label = unique(infra_index$country)[24]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[25]),
                 label = unique(infra_index$country)[25]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[26]),
                 label = unique(infra_index$country)[26]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[27]),
                 label = unique(infra_index$country)[27]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[28]),
                 label = unique(infra_index$country)[28]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[29]),
                 label = unique(infra_index$country)[29]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[30]),
                 label = unique(infra_index$country)[30]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[31]),
                 label = unique(infra_index$country)[31]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[32]),
                 label = unique(infra_index$country)[32]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[33]),
                 label = unique(infra_index$country)[33]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[34]),
                 label = unique(infra_index$country)[34]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[35]),
                 label = unique(infra_index$country)[35]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[36]),
                 label = unique(infra_index$country)[36]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[37]),
                 label = unique(infra_index$country)[37]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[38]),
                 label = unique(infra_index$country)[38]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[39]),
                 label = unique(infra_index$country)[39]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[40]),
                 label = unique(infra_index$country)[40]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[41]),
                 label = unique(infra_index$country)[41]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[42]),
                 label = unique(infra_index$country)[42]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[43]),
                 label = unique(infra_index$country)[43]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[44]),
                 label = unique(infra_index$country)[44]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[45]),
                 label = unique(infra_index$country)[45]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[46]),
                 label = unique(infra_index$country)[46]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[47]),
                 label = unique(infra_index$country)[47]),
            list(method = "restyle",
                 args = list("transforms[0].value", unique(infra_index$country)[48]),
                 label = unique(infra_index$country)[48])
          )
        )
      )
    )

p

# Create a shareable link to your chart
# Set up API credentials: https://plot.ly/r/getting-started
#api_create(p, filename="Dropdown_infra", fileopt = 'overwrite')


saveWidget(as_widget(p), file="dropdown_infra_index.html")





