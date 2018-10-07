#design choices
design_choices <- c(
  "Completly randomized design (CRD)" = "CRD",
  "Randomized complete block design (RCDB)" = "RCBD"
) 

#Function to generate inputs
design_conditional_panels <- function(){
  
  list( #begin list
       #condition 1
       conditionalPanel(
         "input.seldesign == 'CRD'",
         selectInput(inputId = "design_r", label = "Replications", choices= 2:100, selected=2)
       ),
       
       #condition 2
       conditionalPanel(
         "input.seldesign == 'RCBD'",
         selectInput(inputId = "design_b", label = "Blocks", choices = 2:100, selected = 2)
       )
        
    
    ) #end list
  
} #end function

