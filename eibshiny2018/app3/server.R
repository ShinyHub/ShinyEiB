#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(stringr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  
  fbook <- reactive({
     
    # if(is.null(dfile)){
    #   return()
    # } else {
      req(input$fileUp, input$selSheet) 
      dfile<- input$fileUp
      file.copy(dfile$datapath, paste(dfile$datapath, ".xlsx", sep="")) #temporary file
      fieldbook<- readxl::read_excel( paste(dfile$datapath, ".xlsx", sep= ""), sheet = input$selSheet)
    #}
  })
  
  #get sheets
  sheets <- reactive({
    req(input$fileUp)
    dfile <- input$fileUp
    file.copy(dfile$datapath, paste(dfile$datapath, ".xlsx", sep="")) #temporary file
    fieldbook<- readxl::excel_sheets(paste(dfile$datapath, ".xlsx", sep= ""))
  })
  
  
  #renderUI
  
  output$outSheets <- renderUI({
    req(input$fileUp)  # <-----------------------------
    selectInput(inputId = "selSheet", label = "Select sheet", choices = sheets())
  })
  #location
  output$outLoc <- renderUI({
    vars <- fbook()[,"env"] %>% unique()
    selectInput(inputId = "selLoc", label = "Location", choices = vars, multiple = TRUE)
  })
  
  #reactive
  fbfilter<- reactive({
    
    if(input$rbFilter=='Select'){
      
      #selecInput
       loc<- input$selLoc
       if(length(loc)>=1){
         fbfilter<- filter( fbook(), env %in% loc )
       }else{
         data.frame()
       }
       
    } else { #textArea
      
            if(input$txtLoc!=""){
                 
                search_area <- str_split(input$txtLoc, "\\n")[[1]] %>% 
                               str_trim(side="both")
                search_area <- filter(fbook(), env %in% search_area)
              
            } else {
                data.frame()
            }
  
    }
    
    
  })
  
  
  
  #plain html table
  
  output$outfbhtml<- renderTable({
     
     head(fbook())
  }) 
  
  #rhandsontable (spreadsheet)
  
  output$fbhand<- rhandsontable::renderRHandsontable({
    rhandsontable::rhandsontable(fbfilter(), readOnly = T)
    
  })
  
  
  observeEvent( input$btndraft,   {     #begin  observeEvent
  
  #DataTable
  output$fbdt <- DT::renderDataTable({
    DT::datatable( fbfilter(), rownames = FALSE,
                   options = list( scrollX = TRUE, scroller = TRUE), 
                   selection = list(mode = "multiple", selected = NULL)
                   )
  })
  
  }) #end observeEvent
  
  
  #ObserventEvent
  output$dwData <- downloadHandler(
    
    filename = function(){
      paste("data-", Sys.Date(), ".csv", sep="")
    },
    
    content = function(file){
      write.csv( fbfilter(), file= file )
    } 
  )
  
  
  
})
