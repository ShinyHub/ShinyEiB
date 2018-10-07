#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Application 3"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
      #fileInput
      fileInput(inputId="fileUp", label= "Upload dataset", placeholder = "select file", accept = ".xlsx"),
      
      #sheets
      uiOutput("outSheets"),
      
      #radioButon
      radioButtons(inputId="rbFilter", label= "Type of search", 
                   choices = c("Select", "TextArea") ),
      
      #condtionalPanel
      conditionalPanel(
        condition= "input.rbFilter=='Select'",
        uiOutput("outLoc")
      ),
      
      conditionalPanel(
        condition = "input.rbFilter=='TextArea'",
        textAreaInput(inputId="txtLoc", label = "Search locations in TA", value="",
                      placeholder= "paste locations", width = "100px")
        
      ),
      
      #DownloadButoon
      downloadButton(outputId= "dwData", label = "Download"),
      
      #actionButton
      actionButton(inputId= "btndraft", label= "Preview", icon = icon("table"))
      
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      
      tableOutput("outfbhtml"),
      
      rhandsontable::rHandsontableOutput(outputId = "fbhand", height = 400),
      
      br(),
      br(),
      
      DT::dataTableOutput(outputId = "fbdt")
      
    )
  )
))
