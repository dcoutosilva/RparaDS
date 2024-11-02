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

ui <- fluidPage("Histograma da Variável mpg",
                selectInput(
                  inputId = "variavel",
                  label = "Selecione a variável",
                  choices = names(mtcars)
                ),
                plotOutput(outputId = "histograma")
                )
server <- function(input, output, session){
  #sempre recebe input, output, session
  
  #input <- enviar informações ao servidor
  #output <- devolvidos e processados por ela
  
  #output()
  #plotOutput() <- graficos
  #tableOutput() <- tabelas
  #textOutput() <- texto
  #uiOutput() <- html
  #eles especificam onde serão criados e não como.
  
  #render, ele renderiza os resultados para html
  #renderPlot()
  #renderTable()
  #renderText()
  #rendeUI()
  output$histograma <- renderPlot({
    hist(mtcars[[input$variavel]])
  })
  
  
  
}
shinyApp(ui, server)#junta as duas funções, sempre no final
