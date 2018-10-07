library(shiny)
library(shinydashboard)

source("helpers/designinputs.R")
source("helpers/singleinputs.R")

sidebar <- dashboardSidebar(
  width = "200px",
  sidebarMenu(
    
    # menu item 1
    menuItem("Material Management", icon = icon("dashboard"),
             menuSubItem("Material List", tabName = "material", icon = icon("table"))
    ),
    
    # menu item 2
    menuItem("Fieldbook", icon = icon("leaf"),
             menuSubItem("Design", tabName = "design", icon = icon("table"), selected = TRUE)
    ),
    
    # menu item 3
    menuItem("Analysis", icon = icon("pie-chart"),
             menuSubItem("Single environment", tabName = "single", icon = icon("table"))
    )
  
  )
    
)

body <- dashboardBody(
  
  tabItems(
  
    # menu item 1
    tabItem(
      tabName = "material",
      h2("Material management"),
      #display an alert
      shinyalert::useShinyalert(),
      
      selectInput(inputId= "selmtlyear", label = "Select year", choices = 2000:2018, selected = 2014),
      actionButton(inputId= "saverds", label = "Synchronize database", icon = icon("refresh")),
      actionButton(inputId= "viewdt", label= "Show table", icon = icon("table")),
      br(),
      br(),
      DT::dataTableOutput("materialdt")
      
    ),  
    
    # menu item 2
    tabItem(
      tabName = "design",
      h2("Design of experiments"),
      #fileInput
      fileInput(inputId="filegerm", label = "Upload file", placeholder = "selec file...", accept = ".xlsx"),
      #selectInput
      selectInput(inputId = "seldesign", label = "Design", choices = design_choices, selected="CRD"),
      #function to draw different designs
      design_conditional_panels(),
      #action buttona and downloadButton
      actionButton(inputId= "btnPreview", label= "Fieldbook preview", icon = icon("table")),
      downloadButton(outputId= "dwData", label = " Download"),
      br(),
      #Fieldbook preview
      rhandsontable::rHandsontableOutput("fbpreview")
      
      
    ),
    
    # menu item 3
    tabItem(
      tabName = "single",
      h2("Single environment analysis"),
      
      #upload file
      fileInput(inputId= "filesingle", label = "Upload file", accept = ".xlsx"),
      
      #select input
      selectInput("selsingle", "Design", choices = design_choices, selected = "CRD"),
      
      #uiOutput for genotypes
      uiOutput("outsinglegen"),
      
      #function to draw single inputs
      single_conditional_panels(),
      
      br(),
      br(),
      actionButton(inputId= "btnsingle", label = "Run analysis", icon = icon("play-circle"))
      
      
    )
    
  )
  
)

dashboardPage(
  dashboardHeader(
    
    title = "Title of the project",
    titleWidth = "200px"
  ),
  sidebar,
  body
)