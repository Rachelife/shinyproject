library(shinyApps)
library(shiny)
library(ggplot2)
library(babynames)
library(container)
library(wordcloud2)

UI <- navbarPage("Baby Names in the US from 1800 to 2017", # create description panel
                 tabPanel("Description", 
                          h4('Analysing the baby names in US'),
                          hr(),
                          textOutput("text")
                          ),
                 
                 tabPanel("Word Cloud", 
                          h4('Word Cloud View of the baby names in US'),
                          hr(),
                          wordcloud2Output(outputId = "cloud")
                 ),
                 
                 tabPanel("plots",
                          h4("How popular is your name"),
                          textInput("yourname", label = "Input Your Name here:"),
                          plotOutput("plot1"),
                          plotOutput("plot2")
                               ),
                 
                 tabPanel("Table",
                          h4("Finding the rank of popular name of the year between 1880 and 2017"),
                          fluidRow(
                              column(3, 
                                     textInput("year","Select Year:"),
                                     selectInput("sex", "Select Gender:",
                                                 c('Boy' = "M",
                                                   'Girl' = "F")
                                     ),
                                     textOutput("result")
                                     )
                              ),
                          tableOutput("table"))
                 )
