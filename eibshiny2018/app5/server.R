library(shiny)

shinyServer(function(input, output) {
   
  # example data 1
  output$tbl1 <- DT::renderDataTable({
    DT::datatable(iris, rownames = F,
                  options = list(scrollX = T, scroller = T))
    
  })
  
  # example data 2
  output$tbl2 <- DT::renderDataTable({
    DT::datatable(cars, rownames = F,
                  options = list(scrollX = T, scroller = T))
    
  })

})
