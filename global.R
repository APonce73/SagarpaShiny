## Load required packages
#library("dplyr")
#library("mxmaps")
#library("geojsonio")
#library("jsonlite")
#library("shiny")
#library("leaflet")
library("RColorBrewer")
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

dir()
getwd() #Para preguntar en donde esta el directorio que busca
setwd("~/Dropbox/JANO/2016/Conabio/Agrobiodiversidad_Regionales/Datos SAGARPA/")
dir()
Municipios <- read.csv("Cultivos_de_Tu_Municipio_2015.csv", header = T, sep = "," , dec = ".")
head(Municipios)
names(Municipios) <- c("Clav.Entid", "Entidad", "Clav.Mun", "Municipio", "ProducID", "Cultivo", "SupCosechHa", "VolProd_Ton", "VolProd_Pesos", "VolProd_SupCosech")
names(Municipios)

Municipios$Clav.Mun <- sprintf("%03d", Municipios$Clav.Mun)
Municipios$Clav.Entid <- sprintf("%02d", Municipios$Clav.Entid)

head(Municipios)
IDCode <- paste(Municipios$Clav.Entid, Municipios$Clav.Mun, sep = "")

Municipios <- data.frame(IDCode, Municipios)

head(Municipios)
names(Municipios)[1] <- c("region")
str(Municipios)

data("df_mxmunicipio")
head(df_mxmunicipio)
dim(df_mxmunicipio)

#Solo valores con pvalue de beta < 0.05
TTT <- df_mxmunicipio[,1:8]
head(TTT)
str(TTT)

#Para el Area
MxMunicipios <- merge(TTT, Municipios, by = "region")
#MxMunicipios <- merge(TTT, AreaT2, by = "region")

dim(MxMunicipios)
dim(df_mxmunicipio)
dim(Municipios)

names(Municipios)
head(MxMunicipios)
names(MxMunicipios)
#names(MxMunicipios)[9] <- c("value")
#names(MxMunicipios)[11] <- c("beta")
#la columna 15 es supCosechHa
names(MxMunicipios)[15] <- c("value")

summary(MxMunicipios$Cultivo)
MxMunicipios1 <- MxMunicipios
#df_mxmunicipio$value <-  df_mxmunicipio$indigenous / df_mxmunicipio$pop 
names(MxMunicipios1)
