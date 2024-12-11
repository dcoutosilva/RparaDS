#Verifica Pacotes
pack = c("tidyverse", 
         "ggstance", 
         "lvplot",
         "ggbeeswarm")

for(p in pack){
  if(!require(
    p, character.only = TRUE
  ))
    install.packages(p)
  library(p,character.only = TRUE)
}

ggplot(
  data = diamonds
  ) +
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

ggplot(
  data = smaller, 
  mapping =  aes(
    x = carat)
  ) +
  geom_histogram(binwidth = 0.1)


ggplot(data = smaller, 
       mapping =  aes(
         x = carat, color = cut)) +
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
  

#A função fct_rev reverte a ordem dos níveis de um fator.
#D melhor, j pior
diamonds %>% 
  mutate(
    color = fct_rev(color)
  ) %>% 
  ggplot(
    aes(
      x = color, y = price
    )
  ) +
  geom_boxplot()

#veremos uma relação negativa fraca entre a clarity e price

#i1(pior) e IF(melhor)

ggplot(
  data = diamonds
) +
  geom_boxplot(
    mapping = aes(
      x = clarity, y = price
    )
  )

#carat é muito melhor para estabelecer o preço dos diamantes


#exer 3 pag 99

#instalar o pacote ggstance e crie um boxplot horinzontal.
#como isso se compara a usar coord_flip

ggplot(
  data = mpg
) +
  geom_boxplot(
    mapping = aes(
      x = reorder(
        class, hwy, FUN = median), y = hwy
      )
    ) +
  coord_flip()

#agora com a library ggstance instalada

ggplot(
  data = mpg
) +
  geom_boxploth(
    mapping = aes(
      y = reorder(
        class, hwy, FUN = median
      ), x = hwy 
    )
  )
  
#ATENÇÃO, a diferença de se utilizar a ggstance em relação aos outros gráficos?
#as versões atuais do ggplot2 não requer coord_flip()
#todos os geoms podem escolher a direção 

#exer 4

#letter value plot
#instalar o lvplot e utilizar geom_lv
#preços X corte


ggplot(
  diamonds, 
  aes(
    x = cut, y = price
  )
) +
  geom_lv()

#cada caixa é um percentil, como saber o valor dela?

#Exer 5
#comparar geom_violin() com um geom_histogram facetado ou geom_freqpoly colorido.

#a)freqpoly
ggplot(
  data = diamonds,
  mapping = aes(
    x = price,
    y = ..density..
  )
) +
  geom_freqpoly(
    mapping = aes(
      color = cut
    ), bindwidth = 500
  )

#b) geom_histogram

ggplot(
  data = diamonds,
  mapping = aes(
    x = price
  )
) + 
  geom_histogram() +
  facet_wrap(
    ~cut, ncol = 1,
    scales = "free_y"
  )

#c)geom_violin

ggplot(
  data = diamonds,
  mapping = aes(
    x = cut, y = price
  )
) + 
  geom_violin() +
  coord_flip()


#exer 6.
#fazendo por dois métodos.
#geom_quasirandom() e #geom_beeswarm()

ggplot(
  data = mpg
) +
  geom_quasirandom(
    mapping = aes(
      x = reorder(
        class, hwy, FUN = median
      ),
      y = hwy
    )
  )

ggplot(
  data = mpg
) +
  geom_quasirandom(
    mapping = aes(
      x = reorder(
        class, hwy, FUN = median
      ),
      y = hwy
    ),
    method = "tukey"
  )

ggplot(
  data = mpg
) +
  geom_quasirandom(
    mapping = aes(
      x = reorder(
        class, hwy, FUN = median
      ),
      y = hwy
    ),
    method = "tukeyDense"
  )

ggplot(
  data = mpg
) +
  geom_quasirandom(
    mapping = aes(
      x = reorder(
        class, hwy, FUN = median
      ),
      y = hwy
    ),
    method = "frowney"
  )

ggplot(
  data = mpg
) +
  geom_quasirandom(
    mapping = aes(
      x = reorder(
        class, hwy, FUN = median
      ),
      y = hwy
    ),
    method = "smiley"
  )

ggplot(
  data = mpg
) +
  geom_beeswarm(
    mapping = aes(
      x = reorder(class, hwy, FUN= median),
      y = hwy
    )
  )


#Duas variáveis Categóricas

#covariação entre variáveis

ggplot(data = diamonds) +
  geom_count(mapping = aes(
    x = cut, y = color
  ))
diamonds %>% 
  count(color, cut)