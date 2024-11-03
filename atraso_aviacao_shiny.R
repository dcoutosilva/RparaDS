#Verifica Pacotes
pack = c( "shiny"
         ,"nycflights13"
         ,"dados"
         ,"dplyr"
         ,"ggplot2")

for(p in pack){
  if(!require(
    p, character.only = TRUE
  ))
    install.packages(p)
  library(p,character.only = TRUE)
}


ui <- fluidPage(
  dateInput("date", "Escolha o dia", value = "2013-01-01"),
  tableOutput("summaryTable"),
  plotOutput("flightPlot")
)#dentro da ui, eu apenas chamo os elementos prontos
#os elementos serão modificados na server

server <- function(input, output) {
  data_filtered <- reactive({
#reactive filtra os dados de voos de acordo com a escolha do usuário
    flights %>%
      filter(as.Date(time_hour) == input$date) %>%
      group_by(carrier) %>%
      summarise(#fazendo para cada companhia?
        numeroVoos = n(),
        atrasoPartida = mean(dep_delay, na.rm = TRUE),
        atrasoChegada = mean(arr_delay, na.rm = TRUE)
      )
  })
  
  output$summaryTable <- renderTable({
    resumo <- data_filtered() %>%
      summarise(
        "Número de voos" = sum(numeroVoos),#soma de todas as companhias?
        "Atraso médio de partida (min)" = mean(atrasoPartida, na.rm = TRUE),
        "`Atraso médio de chegada (min)`" = mean(atrasoChegada, na.rm = TRUE)
      )
    resumo
  })
  #error, os valores não batem com o site
  
  output$flightPlot <- renderPlot({
    ggplot(data_filtered(), aes(x = carrier, y = numeroVoos, fill = carrier)) +
      geom_bar(stat = "identity") +
      labs(x = "Empresa", y = "Número de voos", title = "Número de voos por empresa") +
      theme_minimal()
  })
}

shinyApp(ui, server)
