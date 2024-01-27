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

#geom_



