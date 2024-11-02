#Verifica Pacotes
pack = c("shiny")

for(p in pack){
  if(!require(
    p, character.only = TRUE
  ))
    install.packages(p)
  library(p,character.only = TRUE)
}

#objeto ui
#a ui recebe todo código html
#função chamada server
#chamada da função shinyApp()

ui <- fluidPage("Olá Mundo")
server <- function(input, output, session){
  #sempre recebe input, output, session
  
}
shinyApp(ui, server)#junta as duas funções, sempre no final
