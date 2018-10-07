
#Function to generate inputs
single_conditional_panels <- function(){
  
  list( #begin list
    #condition 1
    conditionalPanel(
      "input.selsingle == 'CRD'|
       input.selsingle == 'RCBD'",
       uiOutput("outsingletraits")
    ),
    
    #condition 2
    conditionalPanel(
      "input.selsingle == 'RCBD'",
      uiOutput("outsingleblock")
    )
    
    
  ) #end list
  
} #end function

