#Verifica Pacotes
pack = c("tidyverse")
for(p in pack){
  if(!require(
    p, character.only = TRUE
  ))
    install.packages(p)
  library(p,character.only = TRUE)
}

ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(
      x = cut
    )
  )
diamonds %>% 
  count(cut)

ggplot(
  data = diamonds
) +
  geom_histogram(
    mapping = aes(
      x = carat
    ), binwidth = 0.5
  )

diamonds %>% 
  count(
    cut_width(carat, 0.5)
  )

smaller <- diamonds %>% 
  filter(carat <3)

ggplot(data = smaller, mapping =  aes(x = carat)) +
  geom_histogram(binwidth = 0.1)


ggplot(data = smaller, mapping =  aes(x = carat, color = cut)) +
  geom_freqpoly(binwidth = 0.1)

#valores típicos

#subgrupos de dados 

#o histograma a seguir mostra a duração em minutos de 272 erupções do
#geiser Old Faithful no Paque nacional de Yellowstone
#os tempos estão agrupados em dois clusters, há erupções curtas e erupções longas


ggplot(
  data = faithful,
  mapping = aes(
    x = eruptions
  )
) +
  geom_histogram( binwidth = 0.25)

#valores incomuns

#ex1

ggplot(diamonds) +
  geom_histogram(
    mapping = aes(x = y), binwidth = 0.5
  )

ggplot(diamonds) +
  geom_histogram(mapping = aes(x = y), binwidth = 0.5) +
  coord_cartesian(ylim = c(0,50))

#valores faltantes
nycflights13::flights %>% 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>% 
  ggplot(
    mapping = aes(
      sched_dep_time
    )
  ) +
  geom_freqpoly(
    mapping = aes(
      color = cancelled
    ),
    bindwidth = 1/4
  )

#esse gráfico não é tão ideal pois há muito voos não cancelados para cancelados.

#covariação

#geom_freqpoly não é tão util para comparações., porque a altura é dada pelo count
#se uns dos grupos for muito menor do que os outros, fica dificil de ver as 
#diferenças, vamos ver no exeomplo abaixo

ggplot(
  data = diamonds,
  mapping = aes(
    x = price
  )
) +
  geom_freqpoly(
    mapping = aes(
      color = cut
    ), binwidth = 500
  )

#para melhorar a comparação, vamos mudar o eixo y
#em vez de count, exibiremos density que é a contagem padronizada para que a area
#de cada poligono de frequencia 

ggplot(
  data=diamonds,
  mapping = aes(
    x = price,
    y = ..density..
  )
) +
  geom_freqpoly(
    mapping = aes(
      color = cut
    ), binwidth = 500
  )
#parece que diamantes fair(justos) tem o preço medio mais alto, isso porque seja 
#os poligonos de frequencia seja mais dificil de interpretar
#veremos a diferença em um boxplot

ggplot(
  data=diamonds,
  mapping = aes(
    x = cut, y = price
  )
) +
  geom_boxplot()
#você tem bem mais informações detalhadas, assim fazendo uma analise melhor.

#vamos trazer outro exemplo

ggplot(
  data=mpg,
  mapping = aes(
    x = class,
    y = hwy
  )
) +
  geom_boxplot()

ggplot(
  data=mpg
) +
  geom_boxplot(
    mapping = aes(
      x = reorder(
        class,
        hwy,
        FUN = median
      ),
      y = hwy
    )
  ) + 
  coord_flip()


#exer1 #pg 99

nycflights13::flights %>% 
  mutate(
    cancelados = is.na(dep_time),
    agend_hora = sched_dep_time %/% 100,
    agend_min = sched_dep_time %% 100,
    agen_hora_min = agend_hora + agend_min /60 
    
  ) %>% 
  ggplot() +
  geom_boxplot(
    mapping = aes(
      x = cancelados, y = agen_hora_min
    )
  )

#exer 2 pag 99

ggplot(
  diamonds,
  aes(
    x = carat, y = price
  )
) +
  geom_point()

#como são muitos pontos nos dados,
#utilizaremos boxplot
#eixos x e y nas suas respectivas variaveis
#A função cut_width(carat, 0.1) cria esses intervalos, 
#o que permite criar boxplots para cada intervalo de carat.

ggplot(
  data = diamonds,
  mapping = aes(
    x = carat, y = price
  )
) +
  geom_boxplot(
    mapping = aes(
      group = cut_width(
        carat, 0.1
      )
    ),
    orientation = "x"
  )
  





