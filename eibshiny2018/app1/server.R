#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   

  output$outName <- renderText({
    
    paste(input$txtName)
    
  })
  
  output$outExp <- renderText({
    
    paste(input$selExp)
    
  })
  
  
  output$outCrop <- renderText({
    
    paste(input$selCrop)
    
  })
  
  
  output$outFileName <- renderText({
    
    infile <- input$fileUp
    out <- infile$name
    
  })
  
  output$outFilePath <- renderText({
    infile <- input$fileUp
    out <- infile$datapath
    
  })
  
  output$outFileType <- renderText({
    infile <- input$fileUp
    out <- infile$type
    
  })
  
  
  
})
