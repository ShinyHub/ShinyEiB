library(shiny)
library(RMySQL)

shinyServer(function(input, output) {
  
  
  observe({
    showModal(modalDialog(
      title = "Welcome Ivan!!",
      "Body text"
    ))
  })
  
  connectdb <- reactive({
    #db connection
    mydb <- dbConnect(MySQL(), 
                      user = "workshop", 
                      password = "workshop", 
                      host = "176.34.248.121",
                      dbname = "workshop")
    #year
    year <- as.character(input$selmtlyear)
    #query
    query <- paste0("select * from ped_family where pedYear = '",year, "' and Crop_CropId = 'SO'")
    res <- dbGetQuery(mydb, query)
    dbDisconnect(mydb)
    res
  })
  
  #observeEvent (save data)
  observeEvent(input$saverds, {
    
    
    saveRDS(object = connectdb(), file = "material/pedigree.rds")    
    #message
    txt <- paste("The genotypes from", as.character(input$selmtlyear), "have been successfully synchronized.")
    #shinyAlert package
    shinyalert::shinyalert(title="PERFECTO!", text = txt, type= "success", timer=4000, 
                           showConfirmButton = F )
     
    
  })
  
  #observeEvent (view data)
  observeEvent(input$viewdt,  { #begin observeEvent
    
    df<- connectdb()
    output$materialdt <- DT::renderDataTable({ #begin RenderDataTable
      DT::datatable( df, rownames = FALSE, 
                     options = list(scrollX= TRUE, scroller= TRUE),
                     selection = list(mode = "multiple", selected = NULL)
                     )
    }) #End RenderDataTable
  }) #end observeEvent
  
  
  #reactive (read all the genotypes from the excel file)
  fbmaterial <- reactive({
     req(input$filegerm)
     dfile <- input$filegerm 
     file.copy( dfile$datapath, paste(dfile$datapath, ".xlsx", sep=""))
     fb <- readxl::read_excel( paste(dfile$datapath, ".xlsx", sep =""), sheet = 1)
     fb <- fb$Accession_Number #genotypes
  })
  
  #design
  fbdesign <- reactive({
    
    if(length(fbmaterial())==0 || is.null(fbmaterial())){
       out <- NULL
    } else {
       trt <- fbmaterial() #genotypes or treatments   
       design <- input$seldesign #statistical design
       if(design =="CRD"){
         r <- as.integer(input$design_r) #get number of replications
       } else{
         b<- as.integer(input$design_b) #get number of blocks
       }
       #create randomizations
       fb <- switch(design,
                    RCBD = agricolae::design.rcbd(trt = trt, r=b),
                    CRD = agricolae::design.crd(trt = trt, r =r)
                    )
       out <- fb$book
       out
    }

  })
  
  #observeEvent
  observeEvent(input$btnPreview, {
    
    fb<- fbdesign()
    fb$plots <- as.factor(fb$plots) #reactives are not good for subsetting operations.
    
           output$fbpreview <- rhandsontable::renderRHandsontable({
             rhandsontable::rhandsontable(fb, readOnly = T )
           })
  })
  
  #downloadButton
  
  output$dwData <- downloadHandler(
    
    filename = function(){
       paste("data-", Sys.Date(), ".csv", sep="")
    },
    
    content = function(file){
      
      write.csv(fbdesign(), file, row.names = FALSE)
    }
    
  )
  
  #single env. data
  
  fbsingle <- reactive({
    req(input$filesingle)
    dfile <- input$filesingle 
    file.copy( dfile$datapath, paste(dfile$datapath, ".xlsx", sep=""))
    fb <- readxl::read_excel( paste(dfile$datapath, ".xlsx", sep =""), sheet = 1)
  })
  
  #select genotype
  output$outsinglegen <- renderUI({
    
    req(input$filesingle)
    selectInput(inputId= "selgenotypes", label = "Select genotypes", choices = names(fbsingle()))
    
  })
  
  #select block
  output$outsingleblock <- renderUI({
    
    req(input$filesingle)
    selectInput(inputId= "selblock", label = "Select block", choices = names(fbsingle()))
    
  })
  
  #select trait(s)
  output$outsingletraits <- renderUI({
    
    req(input$filesingle)
    selectInput(inputId= "seltraits", label = "Select traits", choices = names(fbsingle()), multiple = TRUE)
    
  })
  
  #run analysis
  
  observeEvent(input$btnsingle, {
    
    design <- input$selsingle
    fb <- as.data.frame(fbsingle())
    trait <- input$seltraits
    block <- input$selblock
    genotypes<- input$selgenotypes
    
    if(design == "RCBD"){
      pepa::repo.rcbd(traits = trait, geno = genotypes, rep = block, dfr = fb)
    } else{
      pepa::repo.crd(traits = trait, geno = genotypes,dfr = fb)
    }
    
    
  })
  
  
  
  
})
