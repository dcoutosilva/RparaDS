#Verifica Pacotes
pack = c("shiny")

for(p in pack){
  if(!require(
    p, character.only = TRUE
  ))
    install.packages(p)
  library(p,character.only = TRUE)
}
#agora o codigo gera dois inputs e dois outputs

variaveis <- names(mtcars)

ui <- fluidPage(
  selectInput(
    inputId = "variavel_A",
    label = "variavel_A",
    choices = variaveis
  ),
  plotOutput(outputId = "histograma_A"),
  selectInput(
    inputId = "variavel_B",
    label = "variavel_B",
    choices = variaveis,
    selected = variaveis[2],
  ),
  plotOutput(outputId = "histograma_B")
)

server <- function(input, output, session) {
  output$histograma_A <- renderPlot({
    print("Gerando histograma A ...")
    hist(mtcars[[input$variavel_A]], main = "Histograma_A")
  })
  output$histograma_B <- renderPlot({
    print("Gerando histograma B ...")
    hist(mtcars[[input$variavel_B]], main = "Histograma_B")
  })
  
}
shinyApp(ui, server)