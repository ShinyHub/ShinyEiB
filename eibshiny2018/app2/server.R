#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
 #reactive
  fbook <- reactive({
    
    dfile <- input$fileUp
    if(is.null(dfile)){
      return()
    } else {
      file.copy(dfile$datapath, paste(dfile$datapath, ".xlsx", sep="")  )
      fieldbook <-  readxl::read_excel( paste(dfile$datapath, ".xlsx", sep="" ),  sheet = 1)
    }
    
  })
  
  #RenderUI
  output$outVarTrait <- renderUI({
    vars <- names( fbook()  ) 
    selectInput(inputId = "trait", label= "Select trait", choices =  vars)
  })
  #renderUI for trait X
  output$outX <- renderUI({
    vars <- names( fbook()  ) 
    selectInput(inputId = "traitX", label="Select trait (X)", choices=vars)
  })
  #renderUI for trait Y
  output$outY<- renderUI({
    vars <- names(fbook())
    selectInput(inputId = "traitY", label = "Select trait (Y)", choices = vars)
  })
  #Group
  output$outGroup <- renderUI({
    vars <- names(fbook())
    selectInput(inputId = "groupby", label="Grouped by", choices=vars )
  })
  
  
  output$outchart <- renderPlot({
    
    if(input$selChart=="boxplot"){
      req(input$trait, input$groupby)
      p <- ggplot(fbook(),    aes_string( input$groupby, input$trait)) +
           geom_boxplot()
    } else{
      req(input$traitX, input$traitY)
      p <- ggplot(fbook(), aes_string(input$traitX, input$traitY)) +
           geom_smooth()
    }
    
    if(input$xlabel!=""){
      p <- p + xlab(input$xlabel) 
    }
    
    if(input$ylabel!=""){
      p <- p+ ylab(input$ylabel)
    }
    
    p
  
  })
  
  
  
  
 
})
