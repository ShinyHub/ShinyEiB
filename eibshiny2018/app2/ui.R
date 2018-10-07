#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Application 2"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
     
      #fileInput
      fileInput(inputId="fileUp", label = "Upload dataset", 
                placeholder = "select file...", accept=".xlsx"),
      
      #select input
      selectInput(inputId= "selChart", label="Choose graphic", 
                  choices = c("boxplot", "scatterplot"), selected=1),
      
      #uiOutput
      conditionalPanel(      
        condition= "input.selChart=='boxplot'",
        uiOutput("outVarTrait"),
        uiOutput("outGroup")
      ),
      
      conditionalPanel(
        condition = "input.selChart=='scatterplot'",
        uiOutput("outX"),
        uiOutput("outY")
      ),
      
     #labels for the graphic  
     textInput(inputId="xlabel", label = "X label", value=""),
     textInput(inputId= "ylabel", label = "Y label", value = "")
     
    
      
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       
      plotOutput("outchart")
      
      
      
    )
  )
))
