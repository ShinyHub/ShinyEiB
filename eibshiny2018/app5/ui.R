library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  title = "title1", 
  skin = "green",
  
  # header
  dashboardHeader(title = "title2"),
  
  # sidebar
  dashboardSidebar(),
  
  # body
  dashboardBody(
    # source file
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    ),
    
    # row
    fluidRow(
      
      #column a
      column(
        width = 4,
        h1(id = "title", "body title left")
      ),
      
      #column b
      column(
        width = 4,
        align = "center",
        h2("body title center")
      ),
      
      #column c
      column(
        width = 4,
        align = "right",
        h3("body title right")
      )
      
    ),
    
    # banner
    fluidRow(
      column(
        width = 12,
        img(src = "https://thumbor.cgiar.epic-sys.io/gGgsbD05IOKJe25ww9uFzLoTkGA=/fit-in/1920x/https://www.cgiar.org/wp/wp-content/uploads/2018/02/EiB.png", width = "100%")
      )
    ),
    
    # box example
    fluidRow(
      # left
      column(
        width = 6,
        h1("Boxes"),
        fluidRow(
          box(
            title = "box title", status = "warning", solidHeader = TRUE, collapsible = TRUE, width = 12,
            "box content",
            DT::dataTableOutput("tbl1")
          )
        )
      ),
      # right
      column(
        width = 6,
        h1("Boxes"),
        fluidRow(
          box(
            title = "box title", status = "primary", solidHeader = TRUE, collapsible = TRUE, width = 12,
            "box content",
            DT::dataTableOutput("tbl2")
          )
        )
      )
    )
  )
)
