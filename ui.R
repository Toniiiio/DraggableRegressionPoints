library(shiny)
shinyUI( bootstrapPage( 
  fluidRow(
    column(width = 3,
           DragableChartOutput("mychart")
    ),
    column(width = 9,
           verbatimTextOutput("regression")
    )
  )
))
