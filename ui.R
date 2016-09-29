library(shiny)


shinyUI(navbarPage(
  title = "Cultivos en México",
  

  
  tabPanel('Mapa', 
           # Define UI for slider demo application
           shinyUI(fluidPage(
             #Application title
             titlePanel("Cultivos reportados por Sagarpa"),
             h4("Los valores son del"),
             tags$a(href = "http://www.sagarpa.gob.mx/quienesomos/datosabiertos/siap/Paginas/Catalogos.aspx", "Base de Datos"),
             
             sidebarLayout(
               sidebarPanel(
                
                 selectInput(inputId = "Cultivo",
                             label = h6("Cultivo:"), choices = levels(MxMunicipios1$Cultivo),
                             selected = "Acelga"),
                 
                 #selectInput(inputId = "Variable1",
                  #           label = h6("Variable:"), choices = names(MxMunicipios1)[15:18],
                  #           selected = names(MxMunicipios1)[1]),
                             
                br(),
                br(),
                downloadButton('downloadData', 'Download como csv'),
                
                 #c("All", unique(as.character(TableL$Raza_primaria)))),
                 
                 
                 
                 width = 2),
               fluidRow(
                 column(9,leafletOutput("mymap", width = "1300", height = "1000"))
               )
               #leafletOutput("mymap", width = "100%", height = "100%")
             )
           )) 
  ),
  
  tabPanel('Diversidad', 
           # Define UI for slider demo application
           shinyUI(fluidPage(
             #Application title
             titlePanel("Diversidad de cultivos por Estado"),
             h4("Estado")
             
        #     sidebarLayout(
        #       sidebarPanel(
        #        
        #         selectInput(inputId = "Cultivo",
        #                     label = h6("Cultivo:"), choices = levels(MxMunicipios1$Cultivo),
        #                     selected = "Acelga"),
        #         #c("All", unique(as.character(TableL$Raza_primaria)))),
        #         
        #         
        #         
        #         width = 2),
        #       fluidRow(
        #         column(9,leafletOutput("mymap", width = "1000", height = "800"))
        #       )
        #       #leafletOutput("mymap", width = "100%", height = "100%")
        #     )
           )) 
  )
))

#shinyUI(bootstrapPage(
#  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
#  leafletOutput("map", width = "100%", height = "100%"),
#  absolutePanel(top = 10, right = 10,
#                sliderInput("range", "Year", 1997, 2015,
#                            value = 2015, step = 1, sep = "",
#                            animate = animationOptions(interval = 3000, loop = FALSE, 
#                                                       playButton = NULL,
#                                                       pauseButton = NULL)
#                )
#  )
#))