## Load required packages
#library("dplyr")
#library("mxmaps")
#library("geojsonio")
#library("jsonlite")
#library("shiny")
#library("leaflet")
#library("RColorBrewer")
#library("lubridate")
#library("zoo")
#library("stringi")


library(plotly)
library(ggplot2)
library(vegan)
library(mxmaps)
library(leaflet)
library(plyr)
library(dplyr)
library(tidyr)

# Download crime data
## From crimenmexico.diegovalle.net/en/csv
## All local crimes at the state level
tmpdir <- tempdir()
download.file("http://crimenmexico.diegovalle.net/data/fuero-comun-estados.csv.gz",
              file.path(tmpdir, "fuero-comun-estados.csv.gz"))


## Load the crime data
crime <- read.csv(file.path(tmpdir, "fuero-comun-estados.csv.gz"))

## Only intentional homicides
crime <- subset(crime, modalidad == "HOMICIDIOS" & tipo == "DOLOSOS")

## subset the year from the date
crime$year <- as.integer(substr(crime$date, 1, 4))

## Yearly homicide rates
hom <- crime %>%
  mutate(year = year(as.yearmon(date))) %>%
  group_by(year, state_code, tipo, state) %>%
  summarise(total = sum(count, na.rm = TRUE),
            rate = total / mean(population) * 10 ^ 5) %>%
  mutate(region = str_mxstate(state_code),
         id = str_mxstate(state_code))

# Convert the topoJSON to spatial object
data(mxstate.topoJSON)
head(mxstate.topoJSON)

tmpdir <- tempdir()
# have to use RJSONIO or else the topojson isn't valid
write(RJSONIO::toJSON(mxstate.topoJSON), file.path(tmpdir, "state.topojson"))
states <- topojson_read(file.path(tmpdir, "state.topojson"))
head(states@data)
class(states)
names(states)
names(states$id)
states@data
# state codes in a standard format
states$id <- str_mxstate(states@data$id)
