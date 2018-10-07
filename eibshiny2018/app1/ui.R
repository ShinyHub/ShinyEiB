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
  titlePanel("Application 1"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
      #TextInput 
      textInput(inputId= "txtName", label="Experiment project name", value= "SASHA", placeholder = "Enter a name"),
      
      #SelectInput
      selectInput(inputId="selExp", label="Type of experiment", 
                  choices = c("Controlled trial", "Varietal Trial", "Germoplasm trial")),
      
      #SelectizeInput
      selectizeInput(inputId="selCrop", label= "Crop(s)", 
                     choices= c("Potato", "Lentils", "Maize", "Banana"), multiple= TRUE, 
                     options =  list(placeholder= "Select crop(s)", maxItems= 2) ),
      
      #dateInput
      dateInput(inputId= "dateExp", label ="Planting date", value="2018-09-27", format = "yyyy-mm-dd"),
      
      #dateRangeInput
      dateRangeInput(inputId="dateExpRg", label = "Experiments dates", startview = "year"),
      
      #Checkbox
      checkboxInput(inputId= "cbBreeding", label ="Is a breeding experiment?", value= TRUE),
      
      #CheckBoxGroupInput
      checkboxGroupInput(inputId="cbSites", label= "Sites", 
                         choices = c("Peru", "Colombia", "India", "Kenia", "Mexico")),
      
      #textAreaInput
      textAreaInput(inputId="txtNotes", label="Notes", value="", width = "100px"),
      
      #fileInput
      fileInput(inputId="fileUp", label="Upload dataset", placeholder = "select file..."),
      
      #radioButton
      radioButtons(inputId= "radioUnit", label = "Experimental units", 
                   choices =  c("kg/ha", "ton/ha", "ton/acre"))
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      textOutput("outName"),
      textOutput("outExp"),
      textOutput("outCrop"),
      textOutput("outFileName"),
      textOutput("outFilePath"),
      textOutput("outFileType")
      
    )
  )
))
